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
    return InkWell(
      highlightColor: color.withAlpha(50),
      onTap: onSubmit,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: 8,
          right: 8,
        ),
        child: Label(
          text: text.toUpperCase(),
          color: color,
          size: 12,
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}
