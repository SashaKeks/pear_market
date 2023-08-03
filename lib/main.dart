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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: AppNavigationNames.authPage,
      routes: AppNavigation.routes,
      onGenerateRoute: AppNavigation.onGenerateRoute,
    );
  }
}
