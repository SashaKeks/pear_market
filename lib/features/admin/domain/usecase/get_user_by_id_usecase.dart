import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/usecase/usecase.dart';
import 'package:pear_market/features/admin/domain/entity/custom_user_entity.dart';
import 'package:pear_market/features/admin/domain/repository/users_repository.dart';

class GetUserByIdUsecase implements UseCase<CustomUserEntity, String> {
  final UsersRepository _usersRepository;
  GetUserByIdUsecase(this._usersRepository);

  @override
  Future<Either<Failure, CustomUserEntity>> call(
      {required String params}) async {
    return await _usersRepository.getUserById(params);
  }
}
