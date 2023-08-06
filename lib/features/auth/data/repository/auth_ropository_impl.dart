import 'package:firebase_auth/firebase_auth.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<User?> signIn(
      {required String login, required String password}) async {
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: login, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthFailure('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw AuthFailure('Wrong password provided for that user.');
      }
      throw AuthFailure(e.message ?? "Something went wrong, try again");
    }
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
