import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pear_market/core/error/exception.dart';
import 'package:pear_market/core/resources/app_constants.dart';
import 'package:pear_market/features/auth/data/models/user_credential_model.dart';

class AuthLocalDataSource {
  final storage = const FlutterSecureStorage();

  Future<UserCredentialsModel> getLoginAndPasswordFromSecureStorage() async {
    try {
      String? login = await storage.read(key: AppConstants.loginSecStorageKey);
      String? password =
          await storage.read(key: AppConstants.passwordSecStorageKey);
      if (login != null && password != null) {
        return UserCredentialsModel(login: login, password: password);
      }
      throw SharedPreferenceNoUserCredentials();
    } catch (_) {
      throw SharedPreferenceReadException();
    }
  }

  Future<void> addLoginAndPasswordToSecureStorage(
      {required UserCredentialsModel credentials}) async {
    try {
      await storage.write(
          key: AppConstants.loginSecStorageKey, value: credentials.login);
      await storage.write(
          key: AppConstants.passwordSecStorageKey, value: credentials.password);
    } catch (_) {
      throw SharedPreferenceWriteException();
    }
  }
}
