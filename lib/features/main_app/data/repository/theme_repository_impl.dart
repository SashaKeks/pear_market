import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/main_app/data/source/theme_data_source.dart';
import 'package:pear_market/features/main_app/domain/repository/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeDataSource _dataSource;
  ThemeRepositoryImpl(this._dataSource);
  @override
  Future<bool> getThemeMode() async {
    try {
      return await _dataSource.getThemeMode();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> setThemeMode({required bool themeMode}) async {
    try {
      await _dataSource.setThemeMode(themeMode: themeMode);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
