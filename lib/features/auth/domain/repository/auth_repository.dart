import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/auth/domain/entities/user_credentials_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signIn(
      {required UserCredentialsEntity credential});
  Future<Either<Failure, void>> signOut();
}
