import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/app/initializer.dart';
import 'package:fucking_do_it/screens/auth_screen.dart';
import 'package:fucking_do_it/screens/main_screen.dart';

class Navigation {
  final Routes routes = Routes();

  static Navigation get get => getIt<Navigation>();

  static BuildContext context() => get.routes.key.currentContext!;

  static Future<T?>? push<T>(Route<T> route) => get.routes.push(route);

  static Future<T?>? pushAlone<T>(Route<T> route) =>
      get.routes.pushAlone(route);

  static void pop<T>([T? result]) => get.routes.pop();

  static void authScreen() => pushAlone(
        FadeRoute(
          AuthScreen.instance(),
          name: 'auth',
        ),
      );

  static void mainScreen() => pushAlone(
        FadeRoute(
          MainScreen.instance(),
          name: 'main',
        ),
      );
}
