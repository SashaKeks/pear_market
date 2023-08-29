import 'package:pear_market/features/main_app/domain/repository/theme_repository.dart';

class SetThemeModeUseCase {
  final ThemeRepository _themeRepository;
  SetThemeModeUseCase(this._themeRepository);

  Future<void> call({required bool themeMode}) async {
    await _themeRepository.setThemeMode(themeMode: themeMode);
  }
}
