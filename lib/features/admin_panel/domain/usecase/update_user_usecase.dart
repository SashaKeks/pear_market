import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/admin_panel/domain/entity/custom_user.dart';
import 'package:pear_market/features/admin_panel/domain/repository/users_repository.dart';

class UpdateUserUsecase {
  final UsersRepository _usersRepository;
  UpdateUserUsecase(this._usersRepository);

  Future<Either<Failure, void>> call(CustomUser newUser) async {
    return await _usersRepository.updateUser(newUser);
  }
}
