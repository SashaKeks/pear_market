import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/exception.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/auth/data/datasource/local/auth_local_datasource.dart';
import 'package:pear_market/features/auth/data/models/user_credential_model.dart';
import 'package:pear_market/features/auth/domain/entities/user_credentials_entity.dart';
import 'package:pear_market/features/auth/domain/repository/auth_secure_storage_repository.dart';

class AuthSecureStorageRepositoryImpl implements AuthSecureStorageRepository {
  final AuthLocalDataSource _dataSource;
  AuthSecureStorageRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failure, void>> addLoginAndPassword({
    required UserCredentialsEntity credentials,
  }) async {
    try {
      await _dataSource.addLoginAndPasswordToSecureStorage(
        credentials: UserCredentialsModel.fromEntity(credentials),
      );
      return right(null);
    } on SharedPreferenceWriteException {
      return left(LocalDatabaseFailure(
          error: "Could not write data to local database"));
    } catch (_) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredentialsEntity>> getLoginAndPassword() async {
    try {
      final result = await _dataSource.getLoginAndPasswordFromSecureStorage();
      return right(result.toEntity());
    } on SharedPreferenceReadException {
      return left(LocalDatabaseFailure(
          error: "Could not read data from local database"));
    } on SharedPreferenceNoUserCredentials {
      return left(LocalDatabaseFailure(
          error: "Could not find user credentials in local database"));
    } catch (_) {
      return left(UnknownFailure());
    }
  }
}
