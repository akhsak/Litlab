// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyC4FSerniuJrNGQ7N7n7ozY2SVd6fCG-F4',
    appId: '1:651831217940:web:21155703add590f233fc01',
    messagingSenderId: '651831217940',
    projectId: 'test-flutter-53cab',
    authDomain: 'test-flutter-53cab.firebaseapp.com',
    storageBucket: 'test-flutter-53cab.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDG4xjZF-14M8if4cc4gyIqPXQMKw5l2yY',
    appId: '1:651831217940:android:9797325fdc72924833fc01',
    messagingSenderId: '651831217940',
    projectId: 'test-flutter-53cab',
    storageBucket: 'test-flutter-53cab.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5eRUDpwEB79lsNGvZA2pcx15jrsKGPz8',
    appId: '1:651831217940:ios:9768be68692f86c333fc01',
    messagingSenderId: '651831217940',
    projectId: 'test-flutter-53cab',
    storageBucket: 'test-flutter-53cab.firebasestorage.app',
    androidClientId: '651831217940-jqcorrtgsm1dbjjt7pnheurr886b2a7e.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterLitltab',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA5eRUDpwEB79lsNGvZA2pcx15jrsKGPz8',
    appId: '1:651831217940:ios:9768be68692f86c333fc01',
    messagingSenderId: '651831217940',
    projectId: 'test-flutter-53cab',
    storageBucket: 'test-flutter-53cab.firebasestorage.app',
    androidClientId: '651831217940-jqcorrtgsm1dbjjt7pnheurr886b2a7e.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterLitltab',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC4FSerniuJrNGQ7N7n7ozY2SVd6fCG-F4',
    appId: '1:651831217940:web:21155703add590f233fc01',
    messagingSenderId: '651831217940',
    projectId: 'test-flutter-53cab',
    authDomain: 'test-flutter-53cab.firebaseapp.com',
    storageBucket: 'test-flutter-53cab.firebasestorage.app',
  );
}