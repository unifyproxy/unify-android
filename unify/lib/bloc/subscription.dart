import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:unify/global.dart';
import 'package:unify/utils.dart' as utils;

import './proxy_info.dart';

class Subscription {
  final String id;
  String name;
  String url;

  bool enabled = true;

  Subscription(this.url, {this.name = "Untitled"})
      : id = utils.generateRandomID();

  Subscription.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        url = json['url'],
        enabled = json['enabled'];
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'enabled': enabled,
      };

  Proxy parseNode(String source) {
    final contents = source.split('/');
    final protocol = contents.first;
    final contentString = utils.base64Decode(contents.last);

    if (protocol == 'vmess:') {
      // nodeType = NodeType.V2ray;
      return Proxy<V2rayInfo>(
        ProxyType.V2ray,
        V2rayInfo.fromJson(jsonDecode(contentString)),
        id,
        sub: name,
      );
    } else if (protocol == 'ssr:') {
      // nodeType = NodeType.SSR;
      return Proxy<SSRInfo>(
        ProxyType.SSR,
        SSRInfo.fromRawString(contentString),
        id,
        sub: name,
      );
    } else {
      // nodeType = NodeType.Unsupported;
      return Proxy(ProxyType.Unsupported, null, id);
    }
  }

  Future<List<Proxy>> update() async {
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final List<Proxy> nodes = [];
      final urls = utils.base64Decode(res.body);

      for (var url in urls.split('\n')) {
        nodes.add(parseNode(url));
      }

      return nodes;
    }
    return List();
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
      store();
      notifyListeners();
      return true;
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

  void change(String id, {String name, String url}) {
    for (var i = 0; i < _subs.length; i++) {
      if (_subs[i].id == id) {
        if (name != null) {
          _subs[i].name = name;
        }
        if (url != null) {
          _subs[i].url = url;
        }
        store();
        notifyListeners();
      }
    }
  }

  removeSub(String id) {
    _subs = _subs.where((s) => s.id != id).toList();
    store();
    notifyListeners();
  }

  testSub(String url) async {
    final res = await http.get(url);
    return res.statusCode == 200;
  }

  Future<List<Proxy>> updateSubs() async {
    final list = List<Proxy>();
    for (var sub in _subs) {
      list.addAll(await sub.update());
    }

    return list;
  }

  store() async {
    utils.store<Subscription>(_subs, await getSubPath());
  }

  load() async {
    final f = File(await getSubPath());
    final s = jsonDecode(f.readAsStringSync()) as List<dynamic>;
    if (s != null) {
      _subs = s.map((s) => Subscription.fromJson(s)).toList();
    } else {
      _subs = List();
    }
  }
}
