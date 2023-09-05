import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/usecase/usecase.dart';
import 'package:pear_market/features/main_app/domain/entities/theme_mode_entity.dart';
import 'package:pear_market/features/main_app/domain/repository/theme_repository.dart';

class SetThemeModeUseCase implements UseCase<void, ThemeModeEntity> {
  final ThemeRepository _themeRepository;
  SetThemeModeUseCase(this._themeRepository);

  @override
  Future<Either<Failure, void>> call({required ThemeModeEntity params}) async {
    return await _themeRepository.setThemeModeToSharePref(themeMode: params);
  }
}
