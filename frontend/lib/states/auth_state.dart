import 'dart:async';
import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fucking_do_it/utils/navigation.dart';

class AuthState extends BaseState {
  bool showLoading = false;
  bool showSignIn = false;

  @override
  void onLoad() {
    final Stream<User?> stream = FirebaseAuth.instance.authStateChanges();
    StreamSubscription? subscription;
    subscription = stream.listen((user) {
      subscription?.cancel();

      if (user == null) {
        showLoading = false;
        showSignIn = true;
        notify();
      } else {
        openMainScreen();
      }
    });
  }

  Future onSignIn() async {
    showLoading = true;
    showSignIn = false;
    notify();

    try {
      final GoogleAuthProvider authProvider = GoogleAuthProvider();
      await FirebaseAuth.instance.signInWithPopup(authProvider);
      openMainScreen();
    } catch (e) {
      showLoading = false;
      showSignIn = true;
      notify();
    }
  }

  void openMainScreen() => Navigation.mainScreen();
}
