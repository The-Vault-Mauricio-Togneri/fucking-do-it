import 'package:flutter/material.dart';
import 'package:fucking_do_it/utils/localizations.dart';

enum Priority {
  high,
  medium,
  low;

  Color get backgroundColor {
    switch (this) {
      case Priority.high:
        return const Color(0xffffced6);
      case Priority.medium:
        return const Color(0xfffddb96);
      case Priority.low:
        return const Color(0xffc1e1c1);
    }
  }

  Color get textColor {
    switch (this) {
      case Priority.high:
        return const Color(0xff9e293a);
      case Priority.medium:
        return const Color(0xffb1842a);
      case Priority.low:
        return const Color(0xff5b8644);
    }
  }

  String get text {
    switch (this) {
      case Priority.high:
        return Localized.get.priorityHigh;
      case Priority.medium:
        return Localized.get.priorityMedium;
      case Priority.low:
        return Localized.get.priorityLow;
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
