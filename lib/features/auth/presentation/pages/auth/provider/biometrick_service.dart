import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart'
    show AndroidAuthMessages, AuthMessages;
import 'package:local_auth_ios/local_auth_ios.dart'
    show AuthMessages, IOSAuthMessages;

class BiometrickAuth {
  static final LocalAuthentication _auth = LocalAuthentication();
  static Future<bool> canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  static Future<bool> didAuthenticate() async {
    if (!await canAuthenticate()) return false;
    try {
      final List<BiometricType> availableBiometrics =
          await _auth.getAvailableBiometrics();
      if (availableBiometrics.contains(BiometricType.fingerprint) ||
          availableBiometrics.contains(BiometricType.face)) {
        return await _auth.authenticate(
            localizedReason: 'Please authenticate to enter the app',
            options: const AuthenticationOptions(biometricOnly: true),
            authMessages: const <AuthMessages>[
              AndroidAuthMessages(
                signInTitle: 'Oops! Biometric authentication required!',
                cancelButton: 'No thanks',
              ),
              IOSAuthMessages(
                cancelButton: 'No thanks',
              ),
            ]);
      } else {
        return await _auth.authenticate(
            localizedReason: 'Please authenticate to enter the app',
            options: const AuthenticationOptions(biometricOnly: false),
            authMessages: const <AuthMessages>[
              AndroidAuthMessages(
                signInTitle: 'Oops! Biometric authentication required!',
                cancelButton: 'No thanks',
              ),
              IOSAuthMessages(
                cancelButton: 'No thanks',
              ),
            ]);
      }
    } catch (e) {
      return false;
    }
  }
}
