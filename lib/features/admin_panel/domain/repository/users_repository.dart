import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/admin_panel/domain/entity/custom_user.dart';

abstract class UsersRepository {
  Future<Either<Failure, void>> createUser(CustomUser user);
  Future<Either<Failure, void>> deleteUser(CustomUser user);
  Future<Either<Failure, void>> updateUser(CustomUser newUser);
  Future<Either<Failure, List<CustomUser>>> getAllUsers();
}
