import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: const Color(0xffF8F5FF),
    cardColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffF19D38)),
  );
}
