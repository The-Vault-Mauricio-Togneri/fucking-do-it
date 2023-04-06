import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fucking_do_it/screens/auth_screen.dart';
import 'package:fucking_do_it/services/localizations.dart';
import 'package:fucking_do_it/services/navigation.dart';
import 'package:fucking_do_it/services/palette.dart';

class FuckingDoIt extends StatelessWidget {
  const FuckingDoIt();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fucking Do It',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Palette.primary,
        scaffoldBackgroundColor: Palette.white,
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
