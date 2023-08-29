import 'package:shared_preferences/shared_preferences.dart';

class ThemeDataSource {
  Future<SharedPreferences> getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<bool> getThemeMode() async {
    final sharedPreferences = await getPrefs();
    final bool? themeIndex = sharedPreferences.getBool('theme');
    return themeIndex ?? false;
  }

  Future<void> setThemeMode({required bool themeMode}) async {
    final sharedPreferences = await getPrefs();
    await sharedPreferences.setBool('theme', themeMode);
  }
}
