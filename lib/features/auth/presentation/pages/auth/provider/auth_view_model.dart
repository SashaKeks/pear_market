import 'package:flutter/material.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/resources/app_constants.dart';
import 'package:pear_market/core/service/service_navigation.dart';
import 'package:pear_market/features/admin_panel/domain/entity/custom_user.dart';
import 'package:pear_market/features/auth/domain/usecase/add_auth_cred_to_secure_storage.dart';
import 'package:pear_market/features/auth/domain/usecase/get_auth_cred_from_secure_storage_use_case.dart';
import 'package:pear_market/features/auth/domain/usecase/sign_in_usecase.dart';
import 'package:pear_market/features/auth/presentation/pages/auth/provider/biometrick_service.dart';

enum AuthStatus { none, progress, success, failed }

class AuthViewModel extends ChangeNotifier {
  String _login = "";
  String _password = "";
  bool _secureStorageData = false;
  final GetAuthCredFromSecureStorage getAuthCredFromSecureStorage;
  final AddAuthCredToSecureStorage addAuthCredToSecureStorage;
  String _errorMessage = "";
  CustomUser? _user;
  String get eror => _errorMessage;

  AuthStatus _authStatus = AuthStatus.none;
  final SignInUseCase signInUseCase;
  final BuildContext context;

  AuthViewModel(
      {required this.signInUseCase,
      required this.context,
      required this.addAuthCredToSecureStorage,
      required this.getAuthCredFromSecureStorage}) {
    canAuthBiometrick();
  }

  AuthStatus get authStatus => _authStatus;
  bool get showBiometrickButton => _secureStorageData;

  Future<void> getDataFromSecureStorage() async {
    final result = await getAuthCredFromSecureStorage();
    if (result != null) {
      _login = result[AppConstants.loginSecStorageKey]!;
      _password = result[AppConstants.passwordSecStorageKey]!;
    } else {}
    notifyListeners();
  }

  Future<void> canAuthBiometrick() async {
    _errorMessage = "";
    if (await BiometrickAuth.canAuthenticate()) {
      _secureStorageData = true;
    } else {
      _secureStorageData = false;
      _errorMessage = "Your device have no biometrick";
    }
    notifyListeners();
  }

  Future<void> loginCheacker() async {
    _errorMessage = "";
    if (await BiometrickAuth.didAuthenticate()) {
      await getDataFromSecureStorage();
      onLoginButtonPress();
    } else {
      _errorMessage = "Somthing was wrong, try again";
      changeAuthStatus(AuthStatus.failed);
    }
  }

  void onLoginButtonPress() async {
    _errorMessage = "";
    changeAuthStatus(AuthStatus.progress);
    try {
      final result = await signInUseCase(login: _login, password: _password);
      result.fold((l) => throw l, (r) => _user = r);
    } on Failure catch (e) {
      _errorMessage = e.errorMessage;
      changeAuthStatus(AuthStatus.failed);
      return;
    }
    if (_user != null) {
      changeAuthStatus(AuthStatus.success);
      goToPage();
      addAuthCredToSecureStorage(login: _login, password: _password);
    }
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
