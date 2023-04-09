import 'package:flutter/material.dart';
import 'package:fucking_do_it/storage/base_storage.dart';

class BrightnessStorage extends Storage {
  static const FIELD_BRIGHTNESS = 'brightness';

  static Future save(Brightness value) =>
      Storage.setString(FIELD_BRIGHTNESS, value.name);

  static Future<Brightness> load() async {
    final String value = await Storage.getString(FIELD_BRIGHTNESS, 'light');

    return (value == Brightness.light.name)
        ? Brightness.light
        : Brightness.dark;
  }
}
