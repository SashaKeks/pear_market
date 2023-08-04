abstract class AuthRepository {
  Future<void> signIn({
    required String login,
    required String password,
  });
  Future<void> signOut();
}
