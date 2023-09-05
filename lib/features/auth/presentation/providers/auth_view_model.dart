import 'package:flutter/material.dart';
import 'package:pear_market/core/service/navigation_service/navigation_names.dart';
import 'package:pear_market/core/service/user_access_service.dart';
import 'package:pear_market/core/util/enums/data_status_enum.dart';
import 'package:pear_market/features/auth/domain/entities/user_credentials_entity.dart';
import 'package:pear_market/features/auth/domain/usecase/add_auth_cred_to_secure_storage.dart';
import 'package:pear_market/features/auth/domain/usecase/get_auth_cred_from_secure_storage_use_case.dart';
import 'package:pear_market/features/auth/domain/usecase/sign_in_usecase.dart';
import 'package:pear_market/core/service/biometrick_service.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel(
      {required this.signInUseCase,
      required this.context,
      required this.userAccessService,
      required this.addAuthCredToSecureStorage,
      required this.getAuthCredFromSecureStorage}) {
    canAuthBiometrick();
  }
  final BuildContext context;
  final SignInUseCase signInUseCase;
  final UserAccessService userAccessService;
  final GetAuthCredFromSecureStorage getAuthCredFromSecureStorage;
  final AddAuthCredToSecureStorage addAuthCredToSecureStorage;

  UserCredentialsEntity _credentials = UserCredentialsEntity.empty();
  bool _secureStorageData = false;
  String _errorMessage = "";
  String get error => _errorMessage;
  DataStatusEnum _authStatus = DataStatusEnum.none;

  DataStatusEnum get authStatus => _authStatus;
  bool get showBiometrickButton => _secureStorageData;

  Future<void> getDataFromSecureStorage() async {
    final result = await getAuthCredFromSecureStorage();
    result.fold((failure) {
      _errorMessage = failure.errorMessage!;
    }, (credentials) {
      _credentials = credentials;
    });

    notifyListeners();
  }

  Future<void> canAuthBiometrick() async {
    if (await BiometrickService.canAuthenticate()) {
      _secureStorageData = true;
    } else {
      _secureStorageData = false;
    }
    notifyListeners();
  }

  Future<void> loginCheacker() async {
    _errorMessage = "";
    if (await BiometrickService.didAuthenticate()) {
      await getDataFromSecureStorage();
      if (_credentials != UserCredentialsEntity.empty()) loginIn();
    } else {
      changeAuthStatus(DataStatusEnum.failed);
    }
  }

  Future<void> loginIn() async {
    changeAuthStatus(DataStatusEnum.progress);
    final result = await signInUseCase(params: _credentials);
    result.fold(
      (l) {
        _errorMessage = l.errorMessage!;
        changeAuthStatus(DataStatusEnum.failed);
      },
      (r) async {
        addAuthCredToSecureStorage(params: _credentials);
        await userAccessService.initCurrentUser();
        changeAuthStatus(DataStatusEnum.success);
        goToPage();
      },
    );
  }

  void onLoginButtonPress() {
    _errorMessage = "";
    loginIn();
  }

  void goToPage() => Navigator.pushNamedAndRemoveUntil(
        context,
        AppNavigationNames.homePage,
        (route) => false,
      );

  void changeAuthStatus(DataStatusEnum authStatus) {
    _authStatus = authStatus;
    notifyListeners();
  }

  void onLoginChange(String? login) =>
      _credentials = _credentials.copyWith(login: login);

  void onPasswordChange(String? password) =>
      _credentials = _credentials.copyWith(password: password);
}
