import 'package:clippy_flutter/diagonal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/bloc/proxy_list.dart';
import 'package:unify/bloc/subscription.dart';
import 'package:unify/global.dart';
import 'package:unify/pages/main/states/bottombar_state.dart';
import 'package:unify/pages/proxy_info/proxy_info.dart';
import 'package:unify/pages/setting/setting.dart';
import 'package:unify/pages/subscription/subscription.dart';

import 'mainpage_content.dart';

class MainPage extends StatelessWidget {
  static const ID = "/";

  // This widget is the root of your application.
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
      child: Consumer3<BottomBarState, ProxyListBloc, SubscriptionBloc>(
        builder: (_, bottomBarState, proxyListBloc, subscriptionBloc, __) =>
            MaterialApp(
          title: 'Unify APP',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: GlobalTheme.unifyTheme.mainColor,
            accentColor: GlobalTheme.unifyTheme.accentColor,
          ),
          home: MyHomePage(),
          routes: {
            ProxyInfoPage.ID: (_) =>
                ProxyInfoPage(bottomBarState, proxyListBloc),
            SubscriptionPage.ID: (_) => SubscriptionPage(subscriptionBloc)
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getMainAppBar(),
      drawer: getDrawer(),
      body: MainPageContent(),
    );
  }

  AppBar getMainAppBar() {
    return AppBar(
      title: Text("Unify"),
      leading: Builder(builder: (BuildContext context) {
        return Diagonal(
          child: IconButton(
            icon: const Icon(Icons.menu),
            tooltip: "Menu",
            color: Colors.yellow,
            onPressed: () {
              // open drawer
              var sfd = Scaffold.of(context);
              sfd.openDrawer();

              Scaffold.of(context).showSnackBar(SnackBar(
                content: Container(
                  child: Row(
                    children: <Widget>[
                      Text("Menu Clicked"),
                      FlatButton(
                        child: Text("Close"),
                        onPressed: () {
                          Scaffold.of(context).removeCurrentSnackBar();
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
                elevation: 20,
                duration: Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ));
            },
          ),
          clipHeight: 10,
          axis: Axis.vertical,
          position: DiagonalPosition.TOP_RIGHT,
          clipShadows: [ClipShadow(color: Colors.black, elevation: 0)],
        );
      }),
      actions: <Widget>[
        PopupMenuButton(
          icon: Icon(
            Icons.playlist_add,
          ),
          itemBuilder: (_) {
            return ["hello", "world"]
                .map((t) => PopupMenuItem(
                      child: Text(t),
                      value: t,
                    ))
                .toList();
          },
          onSelected: (s) => print(s),
        ),
      ],
    );
  }

  Drawer getDrawer() {
    return Drawer(
      child: Builder(
        builder: (BuildContext context) => Container(
          color: Theme.of(context).primaryColor,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Container(
                    child: Text(
                      APP_NAME,
                      style: TextStyle(
                        fontSize: 50,
                        color: Theme.of(context).accentColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: ListView(
                      children: [
                        {"name": "Subscription", "id": SubscriptionPage.ID},
                        {"name": "Settings", "id": SettingPage.ID}
                      ]
                          .map(
                            (i) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 1.0),
                              child: Container(
                                key: UniqueKey(),
                                color: GlobalTheme.secondaryBackground,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor:
                                        GlobalTheme.unifyTheme.secondaryColor,
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushNamed(i["id"]);
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      child: Center(
                                        child: Text(i["name"]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
