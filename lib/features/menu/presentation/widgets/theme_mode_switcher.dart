import 'package:flutter/material.dart';
import 'package:pear_market/features/main_app/presentation/providers/main_view_model.dart';
import 'package:provider/provider.dart';

class ThemeModeSwitcher extends StatelessWidget {
  const ThemeModeSwitcher({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final stateRead = context.read<MainViewModel>();
    final stateWatch = context.watch<MainViewModel>();
    return IconButton(
      onPressed: stateRead.changeThemeMode,
      icon: Icon(
        stateWatch.themeModeEntity.isDark ? Icons.light_mode : Icons.dark_mode,
      ),
    );
  }
}
