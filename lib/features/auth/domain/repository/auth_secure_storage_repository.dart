abstract class AuthSecureStorageRepository {
  Future<Map<String, String>?> getLoginAndPasswordFromSecureStorage();
  Future<void> addLoginAndPasswordToSecureStorage(
      {required String login, required String password});
}
