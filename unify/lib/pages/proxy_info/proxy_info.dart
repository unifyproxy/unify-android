import 'package:flutter/material.dart';
import 'package:unify/bloc/proxy_list.dart';
import 'package:unify/global.dart';
import 'package:unify/pages/main/states/bottombar_state.dart';

class ProxyInfoPage extends StatelessWidget {
  static const ID = "ProxyInfoPage";
  final BottomBarState _bottomBarState;
  final ProxyListBloc _proxyListBloc;

  ProxyInfoPage(this._bottomBarState, this._proxyListBloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[Text(_bottomBarState.toString())],
        ),
      ),
    );
  }
}
