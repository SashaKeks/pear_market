abstract class ThemeDataSource {
  Future<bool> getThemeMode();

  Future<void> setThemeMode({required bool themeMode});
}
