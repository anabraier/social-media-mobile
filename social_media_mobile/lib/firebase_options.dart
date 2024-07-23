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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBIehr7KOJj_yOrcJmVCYye_ILIB-F5Wt0',
    appId: '1:787860599614:android:5efbcabe8c59f641edb26f',
    messagingSenderId: '787860599614',
    projectId: 'social-media-mobile-e4dfc',
    storageBucket: 'social-media-mobile-e4dfc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMuWbq8HVYYktwkpIhKluUgs9NUmYMsGc',
    appId: '1:787860599614:ios:699411c3fcc7c203edb26f',
    messagingSenderId: '787860599614',
    projectId: 'social-media-mobile-e4dfc',
    storageBucket: 'social-media-mobile-e4dfc.appspot.com',
    iosBundleId: 'com.example.socialMediaMobile',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBMuWbq8HVYYktwkpIhKluUgs9NUmYMsGc',
    appId: '1:787860599614:ios:699411c3fcc7c203edb26f',
    messagingSenderId: '787860599614',
    projectId: 'social-media-mobile-e4dfc',
    storageBucket: 'social-media-mobile-e4dfc.appspot.com',
    iosBundleId: 'com.example.socialMediaMobile',
  );
}
