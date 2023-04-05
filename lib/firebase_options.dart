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
    apiKey: 'AIzaSyAQDhVw-NKJGtnM-cvGby9d-CzDP84iOS8',
    appId: '1:592514968436:web:474b55523c06b450d0da21',
    messagingSenderId: '592514968436',
    projectId: 'ncu-cs-tutorial-platform',
    authDomain: 'ncu-cs-tutorial-platform.firebaseapp.com',
    storageBucket: 'ncu-cs-tutorial-platform.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB4oHlG3so0u0m0P8pxQimGXPwUnNDtBfc',
    appId: '1:592514968436:android:e35a74fb000bf328d0da21',
    messagingSenderId: '592514968436',
    projectId: 'ncu-cs-tutorial-platform',
    storageBucket: 'ncu-cs-tutorial-platform.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDasaWNNS01Qn2bOkCvnvBqpgf6Ah0oR9A',
    appId: '1:592514968436:ios:57179f0ef9a4d132d0da21',
    messagingSenderId: '592514968436',
    projectId: 'ncu-cs-tutorial-platform',
    storageBucket: 'ncu-cs-tutorial-platform.appspot.com',
    iosClientId: '592514968436-mr3n6me3h6skbs3muecb57q1gaojns1j.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDasaWNNS01Qn2bOkCvnvBqpgf6Ah0oR9A',
    appId: '1:592514968436:ios:57179f0ef9a4d132d0da21',
    messagingSenderId: '592514968436',
    projectId: 'ncu-cs-tutorial-platform',
    storageBucket: 'ncu-cs-tutorial-platform.appspot.com',
    iosClientId: '592514968436-mr3n6me3h6skbs3muecb57q1gaojns1j.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication',
  );
}
