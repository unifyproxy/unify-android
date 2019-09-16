import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unify/utils.dart';

import 'proxy_info.dart';

class ProxyList {
  final _v2rayList = <Proxy>[];
  final _ssrList = <Proxy>[];
}

class ProxyListBloc with ChangeNotifier {
  final ProxyList _proxyList = ProxyList();

  ProxyListBloc() {
    // TODO: implement it
  }

  List<Proxy> getProxyListByType(ProxyType type) {
    switch (type) {
      case ProxyType.V2ray:
        return _proxyList._v2rayList;
        break;
      case ProxyType.SSR:
        return _proxyList._ssrList;
        break;
      case ProxyType.Unsupported:
        return List();
        break;
    }
    return List();
  }

  addSSRServer(SSRInfo ssrInfo, {sub = "None"}) {
    if (_proxyList._ssrList.any((it) => isSSRIdentical(it.node, ssrInfo)))
      return;
    _proxyList._ssrList.add(Proxy(ProxyType.SSR, ssrInfo, sub: sub));
    notifyListeners();
  }

  removeSSRServer(SSRInfo ssrInfo) {
    _proxyList._ssrList.removeWhere((it) => isSSRIdentical(it.node, ssrInfo));
    notifyListeners();
  }

  addV2rayServer(V2rayInfo v2rayInfo, {sub = "None"}) {
    if (_proxyList._v2rayList
        .any((it) => isV2rayIdentical(it.node, v2rayInfo))) {
      return;
    }
    _proxyList._v2rayList.add(Proxy(ProxyType.V2ray, v2rayInfo, sub: sub));
    notifyListeners();
  }

  removeV2rayServer(V2rayInfo v2rayInfo) {
    _proxyList._v2rayList
        .removeWhere((it) => isV2rayIdentical(it.node, v2rayInfo));
    notifyListeners();
  }

  selectV2ray(int index) {
    if (index >= 0 && index < _proxyList._v2rayList.length) {
      _proxyList._v2rayList[index].selected = true;
      notifyListeners();
    }
  }

  selectAllV2ray() {
    _proxyList._v2rayList.forEach((i) => i.selected = true);
    notifyListeners();
  }

  selectSSR(int index) {
    if (index >= 0 && index < _proxyList._v2rayList.length) {
      _proxyList._v2rayList[index].selected = true;
      notifyListeners();
    }
  }

  selectAllSSR() {
    _proxyList._ssrList.forEach((i) => i.selected = true);
    notifyListeners();
  }

  unselectV2ray(int index) {
    if (index >= 0 && index < _proxyList._v2rayList.length) {
      _proxyList._v2rayList[index].selected = false;
      notifyListeners();
    }
  }

  unselectAllV2ray() {
    _proxyList._v2rayList.forEach((i) => i.selected = false);
    notifyListeners();
  }

  unselectSSR(int index) {
    if (index >= 0 && index < _proxyList._v2rayList.length) {
      _proxyList._v2rayList[index].selected = false;
      notifyListeners();
    }
  }

  unselectAllSSR() {
    _proxyList._ssrList.forEach((i) => i.selected = false);
    notifyListeners();
  }
}
