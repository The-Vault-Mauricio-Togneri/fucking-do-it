import 'package:flutter/material.dart';
import 'package:fucking_do_it/utils/navigation.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:fucking_do_it/widgets/label.dart';
import 'package:fucking_do_it/widgets/tertiary_button.dart';

class ConfirmationDialog {
  static Future show({
    required BuildContext context,
    required String message,
    required String buttonCancel,
    required String buttonOk,
    VoidCallback? onConfirm,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          actionsPadding: const EdgeInsets.only(
            top: 10,
            right: 10,
            bottom: 10,
          ),
          backgroundColor: Palette.dialogBackground,
          surfaceTintColor: Palette.dialogBackground,
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Palette.border,
              width: 0.4,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          content: Label(
            text: message,
            color: Palette.primaryText,
            weight: FontWeight.bold,
            size: 16,
          ),
          actions: [
            TertiaryButton(
              text: buttonCancel,
              color: Palette.grey,
              onSubmit: Navigation.pop,
            ),
            TertiaryButton(
              text: buttonOk,
              color: Palette.error,
              onSubmit: () {
                Navigation.pop();
                onConfirm?.call();
              },
            ),
          ],
        );
      },
    );
  }
}
