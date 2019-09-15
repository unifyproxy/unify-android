import 'package:rxdart/rxdart.dart';
import 'package:unify/utils.dart';

import 'proxy_info.dart';

class ProxyList {
  final _v2rayList = <V2rayInfo>[];
  final _ssrList = <SSRInfo>[];
}

class ProxyListBloc {
  final BehaviorSubject<List<V2rayInfo>> _v2rayList =
      BehaviorSubject<List<V2rayInfo>>();
  final BehaviorSubject<List<SSRInfo>> _ssrList =
      BehaviorSubject<List<SSRInfo>>();

  final ProxyList _proxyList = ProxyList();

  Stream<List<V2rayInfo>> get v2rayListStream => _v2rayList.stream;
  Stream<List<SSRInfo>> get ssrListStream => _ssrList.stream;

  ProxyListBloc() {
    // TODO: implement it
  }

  notifySSR() {
    _ssrList.add(_proxyList._ssrList);
  }

  notifyV2ray() {
    _v2rayList.add(_proxyList._v2rayList);
  }

  addSSRServer(SSRInfo ssrInfo) {
    if (_proxyList._ssrList.any((it) => isSSRIdentical(it, ssrInfo))) return;
    _proxyList._ssrList.add(ssrInfo);
    notifySSR();
  }

  removeSSRServer(SSRInfo ssrInfo) {
    _proxyList._ssrList.removeWhere((it) => isSSRIdentical(it, ssrInfo));
    notifySSR();
  }

  addV2rayServer(V2rayInfo v2rayInfo) {
    if (_proxyList._v2rayList.any((it) => isV2rayIdentical(it, v2rayInfo))) {
      return;
    }
    _proxyList._v2rayList.add(v2rayInfo);
    notifyV2ray();
  }

  removeV2rayServer(V2rayInfo v2rayInfo) {
    _proxyList._v2rayList.removeWhere((it) => isV2rayIdentical(it, v2rayInfo));
    notifyV2ray();
  }

  dispose() {
    _v2rayList.close();
    _ssrList.close();
  }
}
