import 'package:rxdart/rxdart.dart';

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

  addSSRServer(SSRInfo ssrInfo) {
    _proxyList._ssrList.add(ssrInfo);
    _ssrList.add(_proxyList._ssrList);
  }

  removeSSRServer(SSRInfo ssrInfo) {
    _proxyList._ssrList.removeWhere(
        (it) => it.host == ssrInfo.host && it.port == ssrInfo.port);
    _ssrList.add(_proxyList._ssrList);
  }

  addV2rayServer(V2rayInfo v2rayInfo) {
    _proxyList._v2rayList.add(v2rayInfo);
    _v2rayList.add(_proxyList._v2rayList);
  }

  removeV2rayServer(V2rayInfo v2rayInfo) {
    _proxyList._v2rayList.removeWhere(
      (it) =>
          it.host == v2rayInfo.host &&
          it.port == v2rayInfo.port &&
          it.add == v2rayInfo.add &&
          it.path == v2rayInfo.path &&
          it.id == v2rayInfo.id,
    );
    _v2rayList.add(_proxyList._v2rayList);
  }

  dispose() {
    _v2rayList.close();
    _ssrList.close();
  }
}
