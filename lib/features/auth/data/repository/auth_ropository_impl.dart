import 'package:firebase_auth/firebase_auth.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<void> signIn({required String login, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: login, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthFailure('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw AuthFailure('Wrong password provided for that user.');
      }
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
