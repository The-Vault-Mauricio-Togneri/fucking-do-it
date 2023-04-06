import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fucking_do_it/app/app.dart';
import 'package:fucking_do_it/app/initializer.dart';

Future main() async {
  await Initializer.set();
  runApp(const FuckingDoIt());
}
