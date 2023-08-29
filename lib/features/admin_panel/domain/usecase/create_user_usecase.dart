import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/admin_panel/domain/entity/custom_user.dart';
import 'package:pear_market/features/admin_panel/domain/repository/users_repository.dart';

class CreateUserUsecase {
  final UsersRepository _usersRepository;
  CreateUserUsecase(this._usersRepository);

  Future<Either<Failure, void>> call(CustomUser user) async {
    return await _usersRepository.createUser(user);
  }
}
