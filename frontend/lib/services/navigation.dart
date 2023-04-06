import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/app/initializer.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/screens/main_screen.dart';
import 'package:fucking_do_it/screens/task_screen.dart';

class Navigation {
  final Routes routes = Routes();

  static Navigation get get => getIt<Navigation>();

  static BuildContext context() => get.routes.key.currentContext!;

  static Future<T?>? push<T>(Route<T> route) => get.routes.push(route);

  static void pop<T>([T? result]) => get.routes.pop();

  static void mainScreen() => push(
        FadeRoute(
          MainScreen.instance(),
          name: 'bank_transactions',
        ),
      );

  static void taskScreen([Task? task]) => get.routes.push(
        FadeRoute(
          TaskScreen.instance(task),
        ),
      );
}
