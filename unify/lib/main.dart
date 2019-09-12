import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:clippy_flutter/diagonal.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[600],
        accentColor: Colors.teal[300],
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
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
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Container(
            color: Colors.white,
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
                        "Unify APP",
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
                  Text("he")
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        child: SafeArea(
          child: Text("tedd"),
        ),
      ),
    );
  }
}
