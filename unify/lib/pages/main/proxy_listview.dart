import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/bloc/proxy_info.dart';
import 'package:unify/bloc/proxy_list.dart';
import 'package:unify/pages/main/states/bottombar_state.dart';
import 'package:unify/pages/proxy_info/proxy_info.dart';

class ProxyListView extends StatefulWidget {
  final BottomBarState _bottomBarState;
  final ProxyListBloc _proxyListBloc;

  ProxyListView(this._bottomBarState, this._proxyListBloc);

  @override
  State<StatefulWidget> createState() => _ProxyListViewState();
}

class _ProxyListViewState extends State<ProxyListView> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: widget._bottomBarState.curType == BottomBarStateEnum.V2RAY
          ? V2RAYProxyListView()
          : SSRProxyListView(widget._bottomBarState, widget._proxyListBloc),
      onRefresh: () async {},
    );
  }
}

class V2RAYProxyListView extends StatefulWidget {
  @override
  V2RAYProxyListViewState createState() => V2RAYProxyListViewState();
}

class V2RAYProxyListViewState extends State<V2RAYProxyListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProxyListBloc>(
      builder: (context, proxyListBloc, _) => ListView.builder(
        itemBuilder: (context, index) {
          final list = proxyListBloc.getProxyListByType(ProxyType.V2ray);
          if (list == null || index >= list.length) return null;
          final item = list[index];
          final V2rayInfo node = item.node;

          return ListTile(
            title: Text(node.ps),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Sub: ${item.sub}"),
                Text("Addr: ${node.add}:${node.port}"),
              ],
            ),
            selected: item.selected,
            onTap: () {
//            Navigator.of(context).push(
//              MaterialPageRoute(
//                builder: (_) => ProxyInfoPage(widget._bottomBarState, null),
//              ),
//            );
              proxyListBloc.unselectAllV2ray();
              proxyListBloc.selectV2ray(index);
            },
          );
        },
      ),
    );
  }
}

class SSRProxyListView extends StatefulWidget {
  final ProxyListBloc _proxyListBloc;
  final BottomBarState _bottomBarState;

  SSRProxyListView(this._bottomBarState, this._proxyListBloc);

  @override
  _SSRProxyListViewState createState() => _SSRProxyListViewState();
}

class _SSRProxyListViewState extends State<SSRProxyListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("ssr $index"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ProxyInfoPage(widget._bottomBarState, null)));
          },
        );
      },
    );
  }
}
