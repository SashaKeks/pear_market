import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/admin_panel/domain/entity/custom_user.dart';
import 'package:pear_market/features/admin_panel/domain/repository/users_repository.dart';

class GetUserByIdUsecase {
  final UsersRepository _usersRepository;
  GetUserByIdUsecase(this._usersRepository);

  Future<Either<Failure, CustomUser>> call(String userId) async {
    return await _usersRepository.getUserById(userId);
  }
}
