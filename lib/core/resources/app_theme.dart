import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: _createMaterialColor(const Color(0xffadc178)),
    scaffoldBackgroundColor: const Color(0xfffefae0),
    textTheme: TextTheme(
      bodyMedium: const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      titleSmall: TextStyle(color: Colors.lightGreen[800]),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.black),
    ),
    appBarTheme: const AppBarTheme(foregroundColor: Colors.white),
  );
  static ThemeData darkTheme = ThemeData(
    primarySwatch: _createMaterialColor(const Color(0xff001529)),
    scaffoldBackgroundColor: const Color(0xff001219),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Color.fromARGB(255, 253, 252, 252),
      ),
      titleSmall: TextStyle(color: Colors.white),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      errorStyle: TextStyle(color: Colors.cyan),
      focusedErrorBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyan)),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.cyan),
      ),
      labelStyle: TextStyle(color: Colors.white),
    ),
    appBarTheme: const AppBarTheme(foregroundColor: Colors.white),
  );

  static MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }
}
