import 'package:flutter/material.dart';

enum Priority {
  high,
  medium,
  low;

  Color get backgroundColor {
    switch (this) {
      case Priority.high:
        return const Color(0xfff9e0e4);
      case Priority.medium:
        return Colors.orange;
      case Priority.low:
        return Colors.green;
    }
  }

  Color get textColor {
    switch (this) {
      case Priority.high:
        return const Color(0xff9e293a);
      case Priority.medium:
        return Colors.orange;
      case Priority.low:
        return Colors.green;
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
