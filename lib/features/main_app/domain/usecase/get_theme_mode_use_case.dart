import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/usecase/usecase.dart';
import 'package:pear_market/features/main_app/domain/entities/theme_mode_entity.dart';
import 'package:pear_market/features/main_app/domain/repository/theme_repository.dart';

class GetThemeModeUseCase implements UseCase<ThemeModeEntity, void> {
  final ThemeRepository _themeRepository;
  GetThemeModeUseCase(this._themeRepository);

  @override
  Future<Either<Failure, ThemeModeEntity>> call({void params}) async {
    return await _themeRepository.getThemeModeFromSharePref();
  }
}
