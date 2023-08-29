abstract class ThemeRepository {
  Future<bool> getThemeMode();
  Future<void> setThemeMode({required bool themeMode});
}
