import 'package:flutter/material.dart';
import 'package:fucking_do_it/storage/brightness_storage.dart';
import 'package:fucking_do_it/utils/palette.dart';

class BrightnessManager {
  static Brightness current = Brightness.light;

  static bool get isDarkMode => current == Brightness.dark;

  static Future init() async {
    current = await BrightnessStorage.load();
    Palette.set(current);
  }

  static void darkMode() {
    current = Brightness.dark;
    Palette.set(current);
    BrightnessStorage.save(current);
  }

  static void lightMode() {
    current = Brightness.light;
    Palette.set(current);
    BrightnessStorage.save(current);
  }
}
