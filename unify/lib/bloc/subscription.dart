import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unify/utils.dart' as utils;

import './proxy_info.dart';

class Subscription {
  final String url;
  final String name;

  List<Proxy> _nodes;

  List<Proxy> get node => _nodes;

  Subscription(this.url, {this.name: "untitled"});

  Proxy parseNode(String source) {
    final contents = source.split('/');
    final protocol = contents.first;
    final contentString = utils.base64Decode(contents.last);

    if (protocol == 'vmess:') {
      // nodeType = NodeType.V2ray;
      return Proxy<V2rayInfo>(
        ProxyType.V2ray,
        V2rayInfo.fromJson(jsonDecode(contentString)),
      );
    } else if (protocol == 'ssr:') {
      // nodeType = NodeType.SSR;
      return Proxy<SSRInfo>(
        ProxyType.SSR,
        SSRInfo.fromRawString(contentString),
      );
    } else {
      // nodeType = NodeType.Unsupported;
      return Proxy(ProxyType.Unsupported, null);
    }
  }

  Future<bool> update() async {
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final List<Proxy> nodes = [];
      final urls = utils.base64Decode(res.body);

      for (var url in urls.split('\n')) {
        nodes.add(parseNode(url));
      }

      _nodes = nodes;
      return true;
    }
    return false;
  }
}

class SubscriptionBloc {
  final StreamController<List<Subscription>> _subsStreamController =
      StreamController<List<Subscription>>.broadcast();

  List<Subscription> _subs = <Subscription>[];

  Stream<List<Subscription>> get subs => _subsStreamController.stream;

  dispose() {
    _subsStreamController.close();
  }

  bool addSub(Subscription sub) {
    if (!_subs.any((s) => s.url == sub.url)) {
      RegExp reg = RegExp(
          "https?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{2,256}\\.[a-z]{2,6}\\b([-a-zA-Z0-9@:%_\\+.~#?&//=]*)",
          unicode: true,
          multiLine: true);
      final result = reg.hasMatch(sub.url);
      if (!result) {
        return false;
      }
      _subs.add(sub);
      _subsStreamController.sink.add(_subs);
      return true;
    }
    return false;
  }

  removeSub(Subscription sub) {
    _subs = _subs.where((s) => s.url != sub.url).toList();
    _subsStreamController.sink.add(_subs);
  }

  testSub(String url) async {
    final res = await http.get(url);
    return res.statusCode == 200;
  }

  updateSubs() {
    _subs.forEach((sub) async => await sub.update());
    _subsStreamController.sink.add(_subs);
  }
}
