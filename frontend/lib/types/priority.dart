import 'package:flutter/material.dart';

enum Priority {
  high,
  medium,
  low;

  Color get backgroundColor {
    switch (this) {
      case Priority.high:
        return const Color(0xFFFFCED6);
      case Priority.medium:
        return const Color(0xFFfddb96);
      case Priority.low:
        return const Color(0xFFC1E1C1);
    }
  }

  Color get textColor {
    switch (this) {
      case Priority.high:
        return const Color(0xff9e293a);
      case Priority.medium:
        return const Color(0xFFB1842A);
      case Priority.low:
        return const Color(0xFF76A35D);
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
