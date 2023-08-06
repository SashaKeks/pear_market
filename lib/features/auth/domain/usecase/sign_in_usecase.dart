import 'package:firebase_auth/firebase_auth.dart';

import '../repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  Future<User?> call({required String login, required String password}) async {
    return await _authRepository.signIn(login: login, password: password);
  }
}
