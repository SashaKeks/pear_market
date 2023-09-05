import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/main_app/domain/entities/theme_mode_entity.dart';

abstract class ThemeRepository {
  Future<Either<Failure, ThemeModeEntity>> getThemeModeFromSharePref();
  Future<Either<Failure, void>> setThemeModeToSharePref(
      {required ThemeModeEntity themeMode});
}
