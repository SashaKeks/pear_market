import 'package:flutter/material.dart';
import 'package:pear_market/core/resources/app_theme.dart';
import 'package:pear_market/core/service/navigation_service/navigation.dart';
import 'package:pear_market/core/service/navigation_service/navigation_names.dart';
import 'package:pear_market/features/main_app/presentation/providers/main_view_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, state, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode:
              state.themeModeEntity.isDark ? ThemeMode.dark : ThemeMode.light,
          initialRoute: AppNavigationNames.authPage,
          routes: AppNavigation.routes,
          onGenerateRoute: AppNavigation.onGenerateRoute,
        );
      },
    );
  }
}
