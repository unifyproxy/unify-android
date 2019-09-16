import 'package:rxdart/rxdart.dart';
import 'package:unify/utils.dart';

import 'proxy_info.dart';

class ProxyList {
  final _v2rayList = <Proxy>[];
  final _ssrList = <Proxy>[];
}

class ProxyListBloc {
  final BehaviorSubject<List<Proxy>> _v2rayList = BehaviorSubject();
  final BehaviorSubject<List<Proxy>> _ssrList = BehaviorSubject();

  final ProxyList _proxyList = ProxyList();

  Stream<List<Proxy>> get v2rayListStream => _v2rayList.stream;
  Stream<List<Proxy>> get ssrListStream => _ssrList.stream;

  ProxyListBloc() {
    // TODO: implement it
  }

  notifySSR() {
    _ssrList.add(_proxyList._ssrList);
  }

  notifyV2ray() {
    _v2rayList.add(_proxyList._v2rayList);
  }

  addSSRServer(SSRInfo ssrInfo, {sub = "None"}) {
    if (_proxyList._ssrList.any((it) => isSSRIdentical(it.node, ssrInfo)))
      return;
    _proxyList._ssrList.add(Proxy(ProxyType.SSR, ssrInfo, sub: sub));
    notifySSR();
  }

  removeSSRServer(SSRInfo ssrInfo) {
    _proxyList._ssrList.removeWhere((it) => isSSRIdentical(it.node, ssrInfo));
    notifySSR();
  }

  addV2rayServer(V2rayInfo v2rayInfo, {sub = "None"}) {
    if (_proxyList._v2rayList
        .any((it) => isV2rayIdentical(it.node, v2rayInfo))) {
      return;
    }
    _proxyList._v2rayList.add(Proxy(ProxyType.V2ray, v2rayInfo, sub: sub));
    notifyV2ray();
  }

  removeV2rayServer(V2rayInfo v2rayInfo) {
    _proxyList._v2rayList
        .removeWhere((it) => isV2rayIdentical(it.node, v2rayInfo));
    notifyV2ray();
  }

  selectV2ray(int index) {
    if (index >= 0 && index < _proxyList._v2rayList.length) {
      _proxyList._v2rayList[index].selected = true;
      notifyV2ray();
    }
  }

  selectAllV2ray() {
    _proxyList._v2rayList.forEach((i) => i.selected = true);
    notifyV2ray();
  }

  selectSSR(int index) {
    if (index >= 0 && index < _proxyList._v2rayList.length) {
      _proxyList._v2rayList[index].selected = true;
      notifySSR();
    }
  }

  selectAllSSR() {
    _proxyList._ssrList.forEach((i) => i.selected = true);
    notifySSR();
  }

  unselectV2ray(int index) {
    if (index >= 0 && index < _proxyList._v2rayList.length) {
      _proxyList._v2rayList[index].selected = false;
      notifyV2ray();
    }
  }

  unselectAllV2ray() {
    _proxyList._v2rayList.forEach((i) => i.selected = false);
    notifyV2ray();
  }

  unselectSSR(int index) {
    if (index >= 0 && index < _proxyList._v2rayList.length) {
      _proxyList._v2rayList[index].selected = false;
      notifySSR();
    }
  }

  unselectAllSSR() {
    _proxyList._ssrList.forEach((i) => i.selected = false);
    notifySSR();
  }

  dispose() {
    _v2rayList.close();
    _ssrList.close();
  }
}
