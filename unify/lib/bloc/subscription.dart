import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:unify/utils.dart' as utils;

import './proxy_info.dart';

class Subscription {
  final String url;
  final String name;

  var enabled = true;

  List<Proxy> _nodes;

  List<Proxy> get nodes => _nodes;

  Subscription(this.url, {this.name = "Untitled"});

  Proxy parseNode(String source) {
    final contents = source.split('/');
    final protocol = contents.first;
    final contentString = utils.base64Decode(contents.last);

    if (protocol == 'vmess:') {
      // nodeType = NodeType.V2ray;
      return Proxy<V2rayInfo>(
        ProxyType.V2ray,
        V2rayInfo.fromJson(jsonDecode(contentString)),
        sub: name,
      );
    } else if (protocol == 'ssr:') {
      // nodeType = NodeType.SSR;
      return Proxy<SSRInfo>(
        ProxyType.SSR,
        SSRInfo.fromRawString(contentString),
        sub: name,
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

class SubscriptionBloc with ChangeNotifier {
  List<Subscription> _subs = <Subscription>[];
  List<Subscription> get subs => _subs;

  Future<bool> addSub(Subscription sub) async {
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

      // update automatically
      final ret = await sub.update();
      if (ret) notifyListeners();
      return ret;
    }
    return false;
  }

  bool set(int index, bool enable) {
    if (index >= 0 && index <= this._subs.length) {
      this._subs[index].enabled = enable;
      notifyListeners();
      return true;
    }
    return false;
  }

  removeSub(Subscription sub) {
    _subs = _subs.where((s) => s.url != sub.url).toList();
    notifyListeners();
  }

  testSub(String url) async {
    final res = await http.get(url);
    return res.statusCode == 200;
  }

  updateSubs() async {
    for (var sub in _subs) {
      await sub.update();
    }
    notifyListeners();
  }
}
