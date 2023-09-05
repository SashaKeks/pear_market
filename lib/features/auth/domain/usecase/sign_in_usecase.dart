import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/usecase/usecase.dart';
import 'package:pear_market/features/auth/domain/entities/user_credentials_entity.dart';

import '../repository/auth_repository.dart';

class SignInUseCase implements UseCase<void, UserCredentialsEntity> {
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call({
    required UserCredentialsEntity params,
  }) async {
    return await _authRepository.signIn(credential: params);
  }
}
