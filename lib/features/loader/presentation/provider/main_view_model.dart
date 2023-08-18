import 'package:flutter/material.dart';
import 'package:pear_market/features/loader/domain/usecase/get_theme_mode_use_case.dart';
import 'package:pear_market/features/loader/domain/usecase/set_theme_mode_use_case.dart';

class MainViewModel with ChangeNotifier {
  late bool _isDark;
  final GetThemeModeUseCase _getThemeModeUseCase;
  final SetThemeModeUseCase _setThemeModeUseCase;
  bool get isDark => _isDark;

  MainViewModel(
    this._getThemeModeUseCase,
    this._setThemeModeUseCase,
  ) {
    _isDark = false;
    getPreferences();
  }

  Future<void> changeThemeMode(bool value) async {
    _isDark = value;
    await _setThemeModeUseCase(themeMode: value);
    notifyListeners();
  }

  Future<void> getPreferences() async {
    _isDark = await _getThemeModeUseCase();
    notifyListeners();
  }
}
