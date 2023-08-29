import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pear_market/features/main_app/presentation/main_page.dart';
import 'package:pear_market/features/main_app/presentation/provider/main_view_model.dart';
import 'package:provider/provider.dart';

import 'core/service/service_locator.dart';
import 'firebase_options.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => MainViewModel(getIt(), getIt()),
      child: const MainPage(),
    ),
  );
}
