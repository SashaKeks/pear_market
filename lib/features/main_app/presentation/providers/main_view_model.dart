import 'package:flutter/material.dart';
import 'package:pear_market/features/main_app/domain/entities/theme_mode_entity.dart';
import 'package:pear_market/features/main_app/domain/usecase/get_theme_mode_use_case.dart';
import 'package:pear_market/features/main_app/domain/usecase/set_theme_mode_use_case.dart';

class MainViewModel with ChangeNotifier {
  ThemeModeEntity themeModeEntity = const ThemeModeEntity(ThemeMode.light);
  final GetThemeModeUseCase _getThemeModeUseCase;
  final SetThemeModeUseCase _setThemeModeUseCase;
  final BuildContext context;

  MainViewModel(
    this.context,
    this._getThemeModeUseCase,
    this._setThemeModeUseCase,
  ) {
    getPreferences();
  }

  Future<void> changeThemeMode() async {
    final result = await _setThemeModeUseCase(
      params: themeModeEntity.isDark
          ? const ThemeModeEntity(ThemeMode.light)
          : const ThemeModeEntity(ThemeMode.dark),
    );
    result.fold(
      (failure) => null,
      (r) => getPreferences(),
    );
  }

  Future<void> getPreferences() async {
    notifyListeners();

    final result = await _getThemeModeUseCase();
    result.fold(
      (failure) => null,
      (themeMode) => themeModeEntity = themeMode,
    );
    notifyListeners();
  }
}
