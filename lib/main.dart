import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pear_market/features/main_app/presentation/pages/main_page.dart';
import 'package:pear_market/features/main_app/presentation/providers/main_view_model.dart';
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
      create: (context) => MainViewModel(context, getIt(), getIt()),
      child: const MainPage(),
    ),
  );
}
