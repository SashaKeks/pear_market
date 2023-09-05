import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/usecase/usecase.dart';
import 'package:pear_market/features/admin/domain/entity/custom_user_entity.dart';
import 'package:pear_market/features/admin/domain/repository/users_repository.dart';

class GetAllUsersUsecase implements UseCase<List<CustomUserEntity>, void> {
  final UsersRepository _usersRepository;
  GetAllUsersUsecase(this._usersRepository);

  @override
  Future<Either<Failure, List<CustomUserEntity>>> call({void params}) async {
    return await _usersRepository.getAllUsers();
  }
}
