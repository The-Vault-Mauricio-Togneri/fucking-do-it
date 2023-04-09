import 'package:flutter/material.dart';
import 'package:fucking_do_it/utils/palette.dart';

class Style {
  static const String FONT_NAME = 'CustomFont';

  static ThemeData themeData(BuildContext context) {
    final ThemeData theme = ThemeData();

    return ThemeData(
      scaffoldBackgroundColor: Palette.background,
      fontFamily: FONT_NAME,
      primaryColor: Palette.primary,
      primaryColorDark: Palette.primary,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Palette.black,
        ),
      ),
      colorScheme: theme.colorScheme.copyWith(
        primary: Palette.primary,
        background: Palette.background,
        error: Palette.error,
      ),
    );
  }
}
