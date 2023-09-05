import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/usecase/usecase.dart';
import 'package:pear_market/features/auth/domain/entities/user_credentials_entity.dart';
import 'package:pear_market/features/auth/domain/repository/auth_secure_storage_repository.dart';

class AddAuthCredToSecureStorage
    implements UseCase<void, UserCredentialsEntity> {
  final AuthSecureStorageRepository _authRepository;

  AddAuthCredToSecureStorage(this._authRepository);

  @override
  Future<Either<Failure, void>> call({
    required UserCredentialsEntity params,
  }) async {
    return await _authRepository.addLoginAndPassword(credentials: params);
  }
}
