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
    apiKey: 'AIzaSyD-A45xQPxbmTCJLQKAAjTIDc_BXXof6eI',
    appId: '1:5316932101:web:fc5c4a38061f46017d226c',
    messagingSenderId: '5316932101',
    projectId: 'ml-kit-2f60f',
    authDomain: 'ml-kit-2f60f.firebaseapp.com',
    storageBucket: 'ml-kit-2f60f.firebasestorage.app',
    measurementId: 'G-F5EDGGVQXP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBlekn1VV0cj5-eC-157s-8oLsnYLhu4fE',
    appId: '1:5316932101:android:fd981848ae5994f17d226c',
    messagingSenderId: '5316932101',
    projectId: 'ml-kit-2f60f',
    storageBucket: 'ml-kit-2f60f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-VE3b7IJ6XvPQQyXC22q5b2yoUOFi5JQ',
    appId: '1:5316932101:ios:df32486f751a55d67d226c',
    messagingSenderId: '5316932101',
    projectId: 'ml-kit-2f60f',
    storageBucket: 'ml-kit-2f60f.firebasestorage.app',
    iosBundleId: 'com.example.mlkit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB-VE3b7IJ6XvPQQyXC22q5b2yoUOFi5JQ',
    appId: '1:5316932101:ios:df32486f751a55d67d226c',
    messagingSenderId: '5316932101',
    projectId: 'ml-kit-2f60f',
    storageBucket: 'ml-kit-2f60f.firebasestorage.app',
    iosBundleId: 'com.example.mlkit',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD-A45xQPxbmTCJLQKAAjTIDc_BXXof6eI',
    appId: '1:5316932101:web:fcafff8ecd03e8397d226c',
    messagingSenderId: '5316932101',
    projectId: 'ml-kit-2f60f',
    authDomain: 'ml-kit-2f60f.firebaseapp.com',
    storageBucket: 'ml-kit-2f60f.firebasestorage.app',
    measurementId: 'G-CH7GFQB4NW',
  );
}
