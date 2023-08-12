import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pear_market/core/service/service_navigation.dart';

import 'core/service/service_locator.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  MaterialColor createMaterialColor(Color color) {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color(0xffadc178)),
        scaffoldBackgroundColor: Color(0xfffefae0),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Color.fromARGB(255, 253, 252, 252),
          ),
        ),
        appBarTheme: AppBarTheme(foregroundColor: Colors.white),
      ),
      darkTheme: ThemeData(
        primarySwatch: createMaterialColor(Color(0xff001529)),
        scaffoldBackgroundColor: Color(0xff001219),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Color.fromARGB(255, 253, 252, 252),
          ),
        ),
        appBarTheme: AppBarTheme(foregroundColor: Colors.white),
      ),
      themeMode: ThemeMode.light,
      initialRoute: AppNavigationNames.homePage,
      routes: AppNavigation.routes,
      onGenerateRoute: AppNavigation.onGenerateRoute,
    );
  }
}
