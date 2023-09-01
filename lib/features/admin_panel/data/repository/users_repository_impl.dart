import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/admin_panel/data/datasource/users_datasource.dart';
import 'package:pear_market/features/admin_panel/domain/entity/custom_user.dart';
import 'package:pear_market/features/admin_panel/domain/repository/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersDataSource _usersDataSource;
  UsersRepositoryImpl(this._usersDataSource);
  @override
  Future<Either<Failure, void>> createUser(CustomUser user) async {
    try {
      await _usersDataSource.createUser(user);
      return right(null);
    } on ServerFailure catch (e) {
      return left(ServerFailure(e.errorMessage));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(CustomUser user) async {
    try {
      await _usersDataSource.deleteUser(user);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CustomUser>>> getAllUsers() async {
    try {
      final result = await _usersDataSource.getAllUsers();
      return right(result);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(CustomUser newUser) async {
    try {
      await _usersDataSource.updateUser(newUser);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CustomUser>> getUserById(String userId) async {
    try {
      final result = await _usersDataSource.getUserById(userId);
      return right(result);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
