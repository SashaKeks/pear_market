import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signIn();
  Future<Either<Failure, void>> signOut();
}
