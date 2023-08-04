import '../repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  Future<void> call({required String login, required String password}) async {
    await _authRepository.signIn(login: login, password: password);
  }
}
