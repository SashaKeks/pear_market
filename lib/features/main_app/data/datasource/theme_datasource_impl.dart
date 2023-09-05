import 'package:pear_market/core/resources/app_constants.dart';
import 'package:pear_market/features/main_app/data/datasource/theme_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeDataSourceImpl implements ThemeDataSource {
  Future<SharedPreferences> _getPrefs() async =>
      await SharedPreferences.getInstance();

  @override
  Future<bool> getThemeMode() async {
    final pref = await _getPrefs();
    final bool? themeIndex = pref.getBool(AppConstants.themeModeKey);
    return themeIndex ?? false;
  }

  @override
  Future<void> setThemeMode({required bool themeMode}) async {
    final pref = await _getPrefs();
    pref.setBool(AppConstants.themeModeKey, themeMode);
  }
}
