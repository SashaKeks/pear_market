import 'package:pear_market/features/main_app/domain/repository/theme_repository.dart';

class GetThemeModeUseCase {
  final ThemeRepository _themeRepository;
  GetThemeModeUseCase(this._themeRepository);

  Future<bool> call() async {
    return await _themeRepository.getThemeMode();
  }
}
