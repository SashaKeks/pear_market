import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/admin_panel/domain/entity/custom_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, CustomUser?>> signIn({
    required String login,
    required String password,
  });
  Future<Either<Failure, void>> signOut();
}
