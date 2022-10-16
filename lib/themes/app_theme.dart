import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromARGB(255, 241, 75, 9);
  static final ThemeData lighTheme = ThemeData.light().copyWith(
      primaryColor: primary,
      appBarTheme: const AppBarTheme(backgroundColor: primary, elevation: 2),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 5, backgroundColor: primary, foregroundColor: primary),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            shape: const StadiumBorder(),
            elevation: 3),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: primary),
      ));
}
