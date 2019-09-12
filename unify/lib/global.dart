import 'package:flutter/material.dart';

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
