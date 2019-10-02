import 'dart:io';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart' as path;

class ThemeType {
  final Color mainColor;
  final Color secondaryColor;
  final Color accentColor;

  ThemeType(this.mainColor, this.secondaryColor, this.accentColor);
}

class GlobalTheme {
  static final unifyTheme =
      ThemeType(Colors.teal[600], Colors.teal[300], Colors.tealAccent[400]);
  static final v2rayTheme =
      ThemeType(Colors.blue[600], Colors.blue[300], Colors.blueAccent[400]);
  static final ssrTheme =
      ThemeType(Colors.red[600], Colors.red[300], Colors.redAccent[400]);

  static final background = Colors.grey[400];
  static final secondaryBackground = Colors.grey[200];
}

const APP_NAME = "Unify APP";

Future<String> getConfigPath() async {
  final _path =
      "${(await path.getApplicationDocumentsDirectory()).path}/config";
  final d = Directory(_path);
  if (!await d.exists()) await d.create();
  return _path;
}

Future<String> getSubPath() async {
  final _path = "${await getConfigPath()}/sub.json";
  final f = File(_path);
  if(!await f.exists()) await f.create();
  return _path;
}

Future<String> getPlistPath() async {
  final _path = "${await getConfigPath()}/plist.json";
  final f = File(_path);
  if(!await f.exists()) await f.create();
  return _path;
}
