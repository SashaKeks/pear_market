import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/auth/domain/entities/user_credentials_entity.dart';

abstract class AuthSecureStorageRepository {
  Future<Either<Failure, UserCredentialsEntity>> getLoginAndPassword();
  Future<Either<Failure, void>> addLoginAndPassword(
      {required UserCredentialsEntity credentials});
}
