import 'package:local_auth/local_auth.dart';

class BiometrickService {
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
          // authMessages: const <AuthMessages>[
          // AndroidAuthMessages(
          //   signInTitle: 'Oops! Biometric authentication required!',
          //   cancelButton: 'No thanks',
          // ),
          // IOSAuthMessages(
          //   cancelButton: 'No thanks',
          // ),
          // ],
        );
      }

      // else {
      //   return await _auth.authenticate(
      //     localizedReason: 'Please authenticate to enter the app',
      //     options: const AuthenticationOptions(biometricOnly: false),
      // authMessages: const <AuthMessages>[
      //   AndroidAuthMessages(
      //     signInTitle: 'Oops! Biometric authentication required!',
      //     cancelButton: 'No thanks',
      //   ),
      //   IOSAuthMessages(
      //     cancelButton: 'No thanks',
      //   ),
      // ],
      //   );
      // }
      return false;
    } catch (e) {
      return false;
    }
  }
}
