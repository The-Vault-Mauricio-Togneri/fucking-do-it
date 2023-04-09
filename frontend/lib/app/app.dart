import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fucking_do_it/screens/auth_screen.dart';
import 'package:fucking_do_it/utils/constants.dart';
import 'package:fucking_do_it/utils/localizations.dart';
import 'package:fucking_do_it/utils/navigation.dart';
import 'package:fucking_do_it/utils/palette.dart';

class FuckingDoIt extends StatelessWidget {
  const FuckingDoIt();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ENLocalized().appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Palette.primary,
        focusColor: Palette.primary,
        highlightColor: Palette.primary,
        hintColor: Palette.hint,
        dialogBackgroundColor: Palette.white,
        scaffoldBackgroundColor: Palette.white,
        useMaterial3: true,
        fontFamily: Constants.FONT_NAME,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Palette.primary),
      ),
      navigatorKey: Navigation.get.routes.key,
      localizationsDelegates: const [
        CustomLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: Localized.locales,
      home: AuthScreen.instance(),
    );
  }
}
