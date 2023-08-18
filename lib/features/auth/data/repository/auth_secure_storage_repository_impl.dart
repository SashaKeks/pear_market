import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pear_market/core/resources/app_constants.dart';
import 'package:pear_market/features/auth/domain/repository/auth_secure_storage_repository.dart';

class AuthSecureStorageRepositoryImpl implements AuthSecureStorageRepository {
  final storage = const FlutterSecureStorage();
  @override
  Future<Map<String, String>?> getLoginAndPasswordFromSecureStorage() async {
    String? login = await storage.read(key: AppConstants.loginSecStorageKey);
    String? password =
        await storage.read(key: AppConstants.passwordSecStorageKey);
    if (login != null && password != null) {
      return {
        AppConstants.loginSecStorageKey: login,
        AppConstants.passwordSecStorageKey: password
      };
    }
    return null;
  }

  @override
  Future<void> addLoginAndPasswordToSecureStorage(
      {required String login, required String password}) async {
    await storage.write(key: AppConstants.loginSecStorageKey, value: login);
    await storage.write(
        key: AppConstants.passwordSecStorageKey, value: password);
  }
}
