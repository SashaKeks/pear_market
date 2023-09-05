import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/exception.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/auth/data/datasource/remote/auth_remote_datasource.dart';
import 'package:pear_market/features/auth/data/models/user_credential_model.dart';
import 'package:pear_market/features/auth/domain/entities/user_credentials_entity.dart';
import 'package:pear_market/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(this._authRemoteDataSource);
  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authRemoteDataSource.signOut();
      return right(null);
    } on ServerNotFoundException {
      return left(ServerFailure(error: "User not found"));
    } catch (e) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signIn(
      {required UserCredentialsEntity credential}) async {
    try {
      await _authRemoteDataSource.signIn(
        credentials: UserCredentialsModel.fromEntity(credential),
      );
      return right(null);
    } on ServerNotFoundException {
      return left(ServerFailure(error: "User not found"));
    } on ServerIncorrectUserPassword {
      return left(ServerFailure(error: "Wrong password for this user"));
    } catch (e) {
      return left(UnknownFailure());
    }
  }
}
