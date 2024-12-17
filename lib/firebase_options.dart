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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBq1-Ru_hCTXbKp-fowuB66dg_4mU7dUeU',
    appId: '1:17714348203:web:e109fa07d74739b5ad77ee',
    messagingSenderId: '17714348203',
    projectId: 'myquizapp-4c803',
    authDomain: 'myquizapp-4c803.firebaseapp.com',
    storageBucket: 'myquizapp-4c803.firebasestorage.app',
    measurementId: 'G-4YXP6RFG46',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJ__5eakoU_biZ7xGW_HOJOHr4BBuoQPs',
    appId: '1:17714348203:android:5072b513231614caad77ee',
    messagingSenderId: '17714348203',
    projectId: 'myquizapp-4c803',
    storageBucket: 'myquizapp-4c803.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAxfLMb4CcnRpz2nb7Qp12quVxlrWnHKrg',
    appId: '1:17714348203:ios:98a784cbdb884a9dad77ee',
    messagingSenderId: '17714348203',
    projectId: 'myquizapp-4c803',
    storageBucket: 'myquizapp-4c803.firebasestorage.app',
    androidClientId: '17714348203-hssddfvno1isragoo4nrdd5cj7k480f5.apps.googleusercontent.com',
    iosClientId: '17714348203-8ptock0k2c7csb25v5ge2d3igil02m49.apps.googleusercontent.com',
    iosBundleId: 'com.zenva.quizApp',
  );
}
