import 'package:flutter/material.dart';

class Palette {
  static const Color primary = Colors.blue;
  static const Color transparent = Colors.transparent;
  static const Color error = Color(0xffef5365);
  static const Color success = Color(0xff82b368);
  static const Color black = Color(0xff404040);
  static const Color white = Colors.white;
  static const Color splash = Color(0x0faaaaaa);
  static const Color hint = Color(0xffaaaaaa);

  static Color dialogBackground = Colors.orange;
  static Color background = Colors.orange;
  static Color primaryText = Colors.orange;
  static Color loading = Colors.orange;

  static Color grey = Colors.grey;
  static Color border = const Color(0xffdadada);
  static Color unselected = const Color(0xffdddddd);

  static void set(Brightness brightness) {
    if (brightness == Brightness.light) {
      dialogBackground = PaletteLight.dialogBackground;
      background = PaletteLight.background;
      primaryText = PaletteLight.primaryTextColor;
      loading = PaletteLight.loading;

      grey = PaletteLight.grey;
      border = PaletteLight.border;
      unselected = PaletteLight.unselected;
    } else {
      dialogBackground = PaletteDark.dialogBackground;
      background = PaletteDark.background;
      primaryText = PaletteDark.primaryTextColor;
      loading = PaletteDark.loading;

      grey = PaletteDark.grey;
      border = PaletteDark.border;
      unselected = PaletteDark.unselected;
    }
  }
}

class PaletteLight {
  static const Color dialogBackground = Colors.white;
  static const Color background = Color(0xffedf0fc);
  static const Color primaryTextColor = Color(0xff404040);
  static const Color loading = Palette.primary;

  static const Color grey = Colors.grey;
  static const Color border = Color(0xffdadada);
  static const Color unselected = Color(0xffdddddd);
}

class PaletteDark {
  static const Color dialogBackground = Colors.black;
  static const Color background = Colors.black;
  static const Color primaryTextColor = Colors.white;
  static const Color loading = Colors.white;

  static const Color grey = Colors.grey;
  static const Color border = Color(0xffdadada);
  static const Color unselected = Color(0xffdddddd);
}
