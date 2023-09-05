import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/main_app/data/datasource/theme_datasource.dart';
import 'package:pear_market/features/main_app/data/models/theme_mode_model.dart';
import 'package:pear_market/features/main_app/domain/entities/theme_mode_entity.dart';
import 'package:pear_market/features/main_app/domain/repository/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeDataSource _dataSource;
  ThemeRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, ThemeModeModel>> getThemeModeFromSharePref() async {
    //GET DATA FROM SHARED PREFERANCE AND RETURN OR THROW ERROR
    try {
      return right(ThemeModeModel.fromPref(await _dataSource.getThemeMode()));
    } catch (_) {
      return left(
          ServerFailure(error: "Could not get data from local database"));
    }
  }

  @override
  Future<Either<Failure, void>> setThemeModeToSharePref(
      {required ThemeModeEntity themeMode}) async {
    //SET DATA TO SHARED PREFERANCE OR THROW ERROR
    try {
      await _dataSource.setThemeMode(
          themeMode: ThemeModeModel.fromEntity(themeMode).dataToPref());
      return right(null);
    } catch (_) {
      return left(
          ServerFailure(error: "Failed to write data to local database"));
    }
  }
}
