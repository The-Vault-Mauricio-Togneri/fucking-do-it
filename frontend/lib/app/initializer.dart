import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:fucking_do_it/utils/empty_url_strategy.dart';
import 'package:fucking_do_it/utils/navigation.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;
String? paramTaskId;

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

    getIt.registerSingleton<Navigation>(Navigation());

    paramTaskId = Uri.base.queryParameters['taskId'];

    setUrlStrategy(EmptyUrlStrategy());
  }
}
