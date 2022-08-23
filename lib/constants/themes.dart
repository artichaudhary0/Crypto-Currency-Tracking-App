import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    tabBarTheme: TabBarTheme(
      labelColor: Colors.black,
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black)));
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(elevation: 0, color: Color(0xff15161a)),
  backgroundColor: const Color(0xff15161a),
  scaffoldBackgroundColor: const Color(0xff15161a),
);
