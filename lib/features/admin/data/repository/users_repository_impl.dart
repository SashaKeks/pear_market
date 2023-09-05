import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/exception.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/admin/data/datasource/users_datasource.dart';
import 'package:pear_market/features/admin/data/models/custom_user_model.dart';
import 'package:pear_market/features/admin/domain/entity/custom_user_entity.dart';
import 'package:pear_market/features/admin/domain/repository/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersDataSource _usersDataSource;
  UsersRepositoryImpl(this._usersDataSource);
  @override
  Future<Either<Failure, void>> createUser(CustomUserEntity user) async {
    try {
      await _usersDataSource.createUser(CustomUserModel.fromEntity(user));
      return right(null);
    } on ServerUserWithSuchEmailAlreadyExist {
      return left(ServerFailure(error: "User with such email already exist"));
    } catch (e) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(CustomUserEntity user) async {
    try {
      await _usersDataSource.deleteUser(CustomUserModel.fromEntity(user));
      return right(null);
    } catch (e) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<CustomUserEntity>>> getAllUsers() async {
    try {
      final result = await _usersDataSource.getAllUsers();
      return right(result);
    } on ServerNotFoundException {
      return left(ServerFailure(error: "Users not found"));
    } catch (e) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(CustomUserEntity newUser) async {
    try {
      await _usersDataSource.updateUser(CustomUserModel.fromEntity(newUser));
      return right(null);
    } catch (e) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, CustomUserEntity>> getUserById(String userId) async {
    try {
      final result = await _usersDataSource.getUserById(userId);
      return right(result);
    } catch (e) {
      return left(UnknownFailure());
    }
  }
}
