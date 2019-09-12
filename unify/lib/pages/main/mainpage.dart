import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/bloc/proxy_list.dart';
import 'package:unify/bloc/subscription.dart';
import 'package:unify/global.dart';
import 'package:unify/pages/main/states/bottombar_state.dart';

import 'drawer.dart';
import 'appbar.dart';
import 'mainpage_content.dart';

class MainPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: GlobalConstent.unifyTheme.mainColor,
        accentColor: GlobalConstent.unifyTheme.accentColor,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SubscriptionBloc>(
          builder: (_) => SubscriptionBloc(),
          dispose: (_, bloc) => bloc.dispose(),
        ),
        Provider<ProxyListBloc>(
          builder: (_) => ProxyListBloc(),
          dispose: (_, bloc) => bloc.dispose(),
        ),
        ChangeNotifierProvider<BottomBarState>(
          builder: (_) => BottomBarState(),
        )
      ],
      child: Scaffold(
        appBar: getMainAppBar(),
        drawer: getDrawer(),
        body: MainPageContent(),
      ),
    );
  }
}
