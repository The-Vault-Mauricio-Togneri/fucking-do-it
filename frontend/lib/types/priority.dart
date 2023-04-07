import 'package:flutter/material.dart';

enum Priority {
  high,
  medium,
  low;

  Color get color {
    switch (this) {
      case Priority.high:
        return const Color(0xFFabcf81);
      case Priority.medium:
        return const Color(0xFFecc081);
      case Priority.low:
        return const Color(0xFFfa928d);
    }
  }

  String get text {
    switch (this) {
      case Priority.high:
        return 'High';
      case Priority.medium:
        return 'Medium';
      case Priority.low:
        return 'Low';
    }
  }

  static Priority parse(String name) {
    for (final value in Priority.values) {
      if (value.name == name) {
        return value;
      }
    }

    throw Error();
  }
}
