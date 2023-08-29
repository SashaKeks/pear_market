import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/admin_panel/domain/entity/custom_user.dart';
import 'package:pear_market/features/admin_panel/domain/repository/users_repository.dart';

class GetAllUsersUsecase {
  final UsersRepository _usersRepository;
  GetAllUsersUsecase(this._usersRepository);

  Future<Either<Failure, List<CustomUser>>> call() async {
    return await _usersRepository.getAllUsers();
  }
}
