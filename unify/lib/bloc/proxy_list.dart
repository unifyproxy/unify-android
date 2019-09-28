import 'package:flutter/foundation.dart';
import 'package:unify/utils.dart';

import 'proxy_info.dart';

class ProxyList {
  final _v2rayList = <Proxy>[];
  final _ssrList = <Proxy>[];
}

class ProxyListBloc with ChangeNotifier {
  final ProxyList _proxyList = ProxyList();

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

  changeSubName(String id, String newName) {
    for (var i = 0; i < _proxyList._ssrList.length; i++) {
      if (_proxyList._ssrList[i].subID == id) {
        _proxyList._ssrList[i].sub = newName;
      }
    }

    for (var i = 0; i < _proxyList._v2rayList.length; i++) {
      if (_proxyList._v2rayList[i].subID == id) {
        _proxyList._v2rayList[i].sub = newName;
      }
    }
  }

  addProxy(Proxy proxy) {
    switch (proxy.type) {
      case ProxyType.V2ray:
        addV2rayServer(proxy);
        break;
      case ProxyType.SSR:
        addSSRServer(proxy);
        break;
      default:
    }
  }

  addSSRServer(Proxy proxy) {
    if (_proxyList._ssrList.any((it) => isSSRIdentical(it.node, proxy.node)))
      return;
    _proxyList._ssrList.add(proxy);
    notifyListeners();
  }

  removeSSRServer(SSRInfo ssrInfo) {
    _proxyList._ssrList.removeWhere((it) => isSSRIdentical(it.node, ssrInfo));
    notifyListeners();
  }

  addV2rayServer(Proxy proxy) {
    if (_proxyList._v2rayList
        .any((it) => isV2rayIdentical(it.node, proxy.node))) {
      return;
    }
    _proxyList._v2rayList.add(proxy);
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
