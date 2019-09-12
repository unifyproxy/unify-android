import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:unify/widgets/main/views/drawer.dart';
import 'package:unify/widgets/main/views/mainAppBar.dart';
import 'package:unify/widgets/main/views/mainPage.dart';

class MainWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
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
      appBar: getMainAppBar(context),
      drawer: getDrawer(context),
      body: getMainPage(context),
    );
  }
}
