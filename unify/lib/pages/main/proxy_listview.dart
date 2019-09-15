import 'package:flutter/material.dart';
import 'package:unify/bloc/proxy_info.dart';
import 'package:unify/bloc/proxy_list.dart';
import 'package:unify/bloc/subscription.dart';
import 'package:unify/pages/main/states/bottombar_state.dart';
import 'package:unify/pages/proxy_info/proxy_info.dart';

class ProxyListView extends StatefulWidget {
  final BottomBarState _bottomBarState;
  final ProxyListBloc _proxyListBloc;
  final SubscriptionBloc _subscriptionBloc;

  ProxyListView(
      this._bottomBarState, this._proxyListBloc, this._subscriptionBloc);

  @override
  State<StatefulWidget> createState() => _ProxyListViewState();
}

class _ProxyListViewState extends State<ProxyListView> {
  @override
  void initState() {
    super.initState();
    widget._subscriptionBloc.subs.listen((data) {
      if (data == null) return;
      for (var i in data) {
        for (var j in i.nodes) {
          if (i.nodes == null) return;
          if (j.type == ProxyType.SSR) {
            widget._proxyListBloc.addSSRServer(j.node);
          } else if (j.type == ProxyType.V2ray) {
            widget._proxyListBloc.addV2rayServer(j.node);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: widget._bottomBarState.curType == BottomBarStateEnum.V2RAY
          ? V2RAYProxyListView(
              widget._bottomBarState, widget._proxyListBloc.v2rayListStream)
          : SSRProxyListView(
              widget._bottomBarState, widget._proxyListBloc.ssrListStream),
      onRefresh: () async {
        await widget._subscriptionBloc.updateSubs();
      },
    );
  }
}

class V2RAYProxyListView extends StatefulWidget {
  final Stream<List<V2rayInfo>> _stream;
  final BottomBarState _bottomBarState;

  V2RAYProxyListView(this._bottomBarState, this._stream);

  @override
  V2RAYProxyListViewState createState() => V2RAYProxyListViewState();
}

class V2RAYProxyListViewState extends State<V2RAYProxyListView> {
  List<V2rayInfo> _list;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    widget._stream.listen((list) {
      setState(() {
        _list = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (_list == null || index >= _list.length) return null;
        final item = _list[index];

        return ListTile(
          title: Text(item.ps),
          subtitle: Text("${item.add}:${item.port}"),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProxyInfoPage(widget._bottomBarState, null),
              ),
            );
          },
        );
      },
    );
  }
}

class SSRProxyListView extends StatefulWidget {
  final Stream<List<SSRInfo>> _stream;
  final BottomBarState _bottomBarState;

  SSRProxyListView(this._bottomBarState, this._stream);

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
