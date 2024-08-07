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

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBEQWyKzSJO7lCFKs9_3Bn1hDSh1dLCD2I',
    appId: '1:753455717279:ios:de08d1b38552b1547a3baa',
    messagingSenderId: '753455717279',
    projectId: 'groceries-390c4',
    databaseURL: 'https://groceries-390c4-default-rtdb.firebaseio.com',
    storageBucket: 'groceries-390c4.appspot.com',
    iosBundleId: 'com.example.shoppingList',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC9e39L6LDVzQd9q8SwXtAaO5LDd5_DOkM',
    appId: '1:753455717279:web:0543ed638b2aa9a27a3baa',
    messagingSenderId: '753455717279',
    projectId: 'groceries-390c4',
    authDomain: 'groceries-390c4.firebaseapp.com',
    databaseURL: 'https://groceries-390c4-default-rtdb.firebaseio.com',
    storageBucket: 'groceries-390c4.appspot.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC9e39L6LDVzQd9q8SwXtAaO5LDd5_DOkM',
    appId: '1:753455717279:web:0543ed638b2aa9a27a3baa',
    messagingSenderId: '753455717279',
    projectId: 'groceries-390c4',
    authDomain: 'groceries-390c4.firebaseapp.com',
    databaseURL: 'https://groceries-390c4-default-rtdb.firebaseio.com',
    storageBucket: 'groceries-390c4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBEQWyKzSJO7lCFKs9_3Bn1hDSh1dLCD2I',
    appId: '1:753455717279:ios:de08d1b38552b1547a3baa',
    messagingSenderId: '753455717279',
    projectId: 'groceries-390c4',
    databaseURL: 'https://groceries-390c4-default-rtdb.firebaseio.com',
    storageBucket: 'groceries-390c4.appspot.com',
    iosBundleId: 'com.example.shoppingList',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7o5APEfs7wwwSAcFJLCAQGM3aT0cIElM',
    appId: '1:753455717279:android:3e3578e8f839eecc7a3baa',
    messagingSenderId: '753455717279',
    projectId: 'groceries-390c4',
    databaseURL: 'https://groceries-390c4-default-rtdb.firebaseio.com',
    storageBucket: 'groceries-390c4.appspot.com',
  );

}