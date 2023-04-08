import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/widgets/label.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color borderColor;
  final VoidCallback? onSubmit;
  final Widget? icon;

  const SecondaryButton({
    required this.text,
    required this.textColor,
    required this.borderColor,
    required this.onSubmit,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: borderColor,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          textStyle: TextStyle(
            fontSize: 14,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
          side: BorderSide(
            color: borderColor,
            width: 1,
            style: BorderStyle.solid,
          ),
          shape: const StadiumBorder(),
        ),
        onPressed: onSubmit,
        child: (icon != null)
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon!,
                  const HBox(10),
                  Label(text: text, color: textColor),
                ],
              )
            : Label(text: text, color: textColor),
      ),
    );
  }
}
