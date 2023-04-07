import 'package:flutter/material.dart';
import 'package:fucking_do_it/utils/navigation.dart';

class ConfirmationDialog {
  static Future<bool?> show({
    required String message,
    VoidCallback? callback,
  }) {
    return showDialog(
      context: Navigation.context(),
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: Navigation.pop,
              child: Text('Cancel'.toUpperCase()),
            ),
            TextButton(
              onPressed: () {
                Navigation.pop(true);
                callback?.call();
              },
              child: Text('Ok'.toUpperCase()),
            ),
          ],
        );
      },
    );
  }
}
