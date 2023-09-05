import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/usecase/usecase.dart';
import 'package:pear_market/features/auth/domain/entities/user_credentials_entity.dart';
import 'package:pear_market/features/auth/domain/repository/auth_secure_storage_repository.dart';

class GetAuthCredFromSecureStorage
    implements UseCase<UserCredentialsEntity, void> {
  final AuthSecureStorageRepository _authRepository;

  GetAuthCredFromSecureStorage(this._authRepository);

  @override
  Future<Either<Failure, UserCredentialsEntity>> call({void params}) async {
    return await _authRepository.getLoginAndPassword();
  }
}
