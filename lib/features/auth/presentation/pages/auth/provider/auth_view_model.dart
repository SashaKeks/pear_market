import 'package:flutter/material.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/service/service_navigation.dart';
import 'package:pear_market/features/auth/domain/usecase/sign_in_usecase.dart';
import 'package:pear_market/features/auth/domain/usecase/sign_out_usecase.dart';

enum AuthStatus { none, progress, success, failed }

class AuthViewModel extends ChangeNotifier {
  String _login = "";
  String _password = "";
  String _errorMessage = "";
  String get eror => _errorMessage;

  AuthStatus _authStatus = AuthStatus.none;
  final SignOutUseCase signOutUseCase;
  final SignInUseCase signInUseCase;
  final BuildContext context;

  AuthViewModel(
      {required this.signInUseCase,
      required this.signOutUseCase,
      required this.context});

  AuthStatus get authStatus => _authStatus;

  void onLoginButtonPress() async {
    _errorMessage = "";
    changeAuthStatus(AuthStatus.progress);
    try {
      await signInUseCase(login: _login, password: _password);
    } on Failure catch (e) {
      _errorMessage = e.errorMessage;
      changeAuthStatus(AuthStatus.failed);
      return;
    }
    changeAuthStatus(AuthStatus.success);
    goToPage();
  }

  void goToPage() => Navigator.pushNamedAndRemoveUntil(
      context, AppNavigationNames.homePage, (route) => false);

  void changeAuthStatus(AuthStatus authStatus) {
    _authStatus = authStatus;
    notifyListeners();
  }

  void onLoginChange(String? login) => _login = login ?? "";

  void onPasswordChange(String? password) => _password = password ?? "";
}
