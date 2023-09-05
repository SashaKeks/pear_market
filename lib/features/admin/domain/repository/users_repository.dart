import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/admin/domain/entity/custom_user_entity.dart';

abstract class UsersRepository {
  Future<Either<Failure, void>> createUser(CustomUserEntity user);
  Future<Either<Failure, void>> deleteUser(CustomUserEntity user);
  Future<Either<Failure, void>> updateUser(CustomUserEntity newUser);
  Future<Either<Failure, List<CustomUserEntity>>> getAllUsers();
  Future<Either<Failure, CustomUserEntity>> getUserById(String userId);
}
