import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/states/auth_state.dart';
import 'package:fucking_do_it/utils/localizations.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:fucking_do_it/widgets/image_asset.dart';
import 'package:fucking_do_it/widgets/secondary_button.dart';

class AuthScreen extends StatelessWidget {
  final AuthState state;

  const AuthScreen._(this.state);

  factory AuthScreen.instance() => AuthScreen._(AuthState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<AuthState>(
      state: state,
      builder: (context, state) => Scaffold(
        backgroundColor: Palette.background,
        body: body(),
      ),
    );
  }

  Widget body() {
    if (state.showSignIn) {
      return SignInButton(state);
    } else if (state.showLoading) {
      return const Waiting();
    } else {
      return const Empty();
    }
  }
}

class SignInButton extends StatelessWidget {
  final AuthState state;

  const SignInButton(this.state);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SecondaryButton(
        text: Localized.get.buttonSignInWithGoogle,
        textColor: Palette.black,
        borderColor: Palette.grey,
        onSubmit: state.onSignIn,
        icon: const SizedBox(
          child: ImageAsset(
            path: 'google.png',
            size: 20,
          ),
        ),
      ),
    );
  }
}

class Waiting extends StatelessWidget {
  const Waiting();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: Palette.loading),
    );
  }
}
