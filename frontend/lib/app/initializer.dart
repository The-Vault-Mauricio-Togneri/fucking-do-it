import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fucking_do_it/services/navigation.dart';
import 'package:fucking_do_it/services/palette.dart';
import 'package:get_it/get_it.dart';
import 'package:url_strategy/url_strategy.dart';

final GetIt getIt = GetIt.instance;

class Initializer {
  static Future set() async {
    WidgetsFlutterBinding.ensureInitialized();

    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyBcfG-dMDbsPSrtuzLeB7ZIooiOOMSSqLU',
          authDomain: 'fucking-do-it.firebaseapp.com',
          projectId: 'fucking-do-it',
          storageBucket: 'fucking-do-it.appspot.com',
          messagingSenderId: '1059246213727',
          appId: '1:1059246213727:web:ef0af89f84d0a0b563e9ea',
          measurementId: 'G-3P3D7W9C6Q',
        ),
      );
    } else {
      await Firebase.initializeApp();
    }

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Palette.transparent,
    ));

    setPathUrlStrategy();

    getIt.registerSingleton<Navigation>(Navigation());
  }
}
