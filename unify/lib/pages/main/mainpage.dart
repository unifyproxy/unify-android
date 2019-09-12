import 'package:flutter/material.dart';

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
      body: MainPageContent(),
    );
  }
}
