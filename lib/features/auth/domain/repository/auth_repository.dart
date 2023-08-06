import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> signIn({
    required String login,
    required String password,
  });
  Future<void> signOut();
}
