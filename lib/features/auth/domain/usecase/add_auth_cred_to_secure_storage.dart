import 'package:pear_market/features/auth/domain/repository/auth_secure_storage_repository.dart';

class AddAuthCredToSecureStorage {
  final AuthSecureStorageRepository _authRepository;

  AddAuthCredToSecureStorage(this._authRepository);

  Future<void> call({required String login, required String password}) async {
    return await _authRepository.addLoginAndPasswordToSecureStorage(
        login: login, password: password);
  }
}
