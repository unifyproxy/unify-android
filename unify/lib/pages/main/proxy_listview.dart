import 'package:flutter/material.dart';
import 'package:unify/pages/main/states/bottombar_state.dart';

class ProxyListView extends StatefulWidget {
  final BottomBarState _bottomBarState;

  ProxyListView(this._bottomBarState);

  @override
  _ProxyListViewState createState() => _ProxyListViewState();
}

class _ProxyListViewState extends State<ProxyListView> {
  BottomBarState _bottomBarState;

  @override
  void initState() {
    super.initState();

    _bottomBarState = widget._bottomBarState;
  }

  @override
  Widget build(BuildContext context) {
    return _bottomBarState.curType == BottomBarStateEnum.V2RAY
        ? V2RAYProxyListView()
        : SSRProxyListView();
  }
}

class V2RAYProxyListView extends StatefulWidget {
  @override
  V2RAYProxyListViewState createState() => V2RAYProxyListViewState();
}

class V2RAYProxyListViewState extends State<V2RAYProxyListView> {
  final iii = [
    "hello",
    "tooo",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("v2ray $index"),
          onTap: () {},
        );
      },
    );
  }
}

class SSRProxyListView extends StatefulWidget {
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
          onTap: () {},
        );
      },
    );
  }
}
