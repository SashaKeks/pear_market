import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/admin_panel/domain/entity/custom_user.dart';
import 'package:pear_market/features/admin_panel/domain/repository/users_repository.dart';

class DeleteUserUsecase {
  final UsersRepository _usersRepository;
  DeleteUserUsecase(this._usersRepository);

  Future<Either<Failure, void>> call(CustomUser user) async {
    return await _usersRepository.deleteUser(user);
  }
}
