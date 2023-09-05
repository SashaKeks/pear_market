import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/usecase/usecase.dart';
import 'package:pear_market/features/auth/domain/repository/auth_repository.dart';

class SignOutUseCase implements UseCase<void, void> {
  final AuthRepository _authRepository;

  SignOutUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call({void params}) async {
    return await _authRepository.signOut();
  }
}
