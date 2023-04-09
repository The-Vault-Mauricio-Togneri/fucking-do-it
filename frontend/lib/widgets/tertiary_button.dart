import 'package:flutter/material.dart';
import 'package:fucking_do_it/widgets/label.dart';

class TertiaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onSubmit;
  final Color color;

  const TertiaryButton({
    required this.text,
    required this.onSubmit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onSubmit,
      child: Label(
        text: text.toUpperCase(),
        color: color,
        size: 12,
        weight: FontWeight.bold,
      ),
    );
  }
}
