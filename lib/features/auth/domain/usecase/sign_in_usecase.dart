import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/admin_panel/domain/entity/custom_user.dart';

import '../repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  Future<Either<Failure, CustomUser?>> call(
      {required String login, required String password}) async {
    return await _authRepository.signIn(login: login, password: password);
  }
}
