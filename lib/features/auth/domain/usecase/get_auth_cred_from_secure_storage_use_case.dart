import 'package:pear_market/features/auth/domain/repository/auth_secure_storage_repository.dart';

class GetAuthCredFromSecureStorage {
  final AuthSecureStorageRepository _authRepository;

  GetAuthCredFromSecureStorage(this._authRepository);

  Future<Map<String, String>?> call() async {
    return await _authRepository.getLoginAndPasswordFromSecureStorage();
  }
}
