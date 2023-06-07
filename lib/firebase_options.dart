// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBbdbl-ifzvo6DNEbet2OHQUZuK4zljlg8',
    appId: '1:389112933381:web:e68c118ff4eca31ffb406c',
    messagingSenderId: '389112933381',
    projectId: 'appluy-cf5e4',
    authDomain: 'appluy-cf5e4.firebaseapp.com',
    storageBucket: 'appluy-cf5e4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3N-1EECUo2in7bRFs4MhqmY82afy2E_g',
    appId: '1:389112933381:android:0abdf958783aa9e3fb406c',
    messagingSenderId: '389112933381',
    projectId: 'appluy-cf5e4',
    storageBucket: 'appluy-cf5e4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDfrof2XWf_-AAT2_GVdsEklqyizvuub9Y',
    appId: '1:389112933381:ios:2f6d277d3695c566fb406c',
    messagingSenderId: '389112933381',
    projectId: 'appluy-cf5e4',
    storageBucket: 'appluy-cf5e4.appspot.com',
    iosClientId: '389112933381-n0ok1cfld473j2l16i811no75ls5f0ak.apps.googleusercontent.com',
    iosBundleId: 'com.example.pearMarket',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDfrof2XWf_-AAT2_GVdsEklqyizvuub9Y',
    appId: '1:389112933381:ios:2f6d277d3695c566fb406c',
    messagingSenderId: '389112933381',
    projectId: 'appluy-cf5e4',
    storageBucket: 'appluy-cf5e4.appspot.com',
    iosClientId: '389112933381-n0ok1cfld473j2l16i811no75ls5f0ak.apps.googleusercontent.com',
    iosBundleId: 'com.example.pearMarket',
  );
}