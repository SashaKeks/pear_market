import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/usecase/usecase.dart';
import 'package:pear_market/features/admin/domain/entity/custom_user_entity.dart';
import 'package:pear_market/features/admin/domain/repository/users_repository.dart';

class CreateUserUsecase implements UseCase<void, CustomUserEntity> {
  final UsersRepository _usersRepository;
  CreateUserUsecase(this._usersRepository);

  @override
  Future<Either<Failure, void>> call({required CustomUserEntity params}) async {
    return await _usersRepository.createUser(params);
  }
}
