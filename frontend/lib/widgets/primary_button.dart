import 'package:flutter/material.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:fucking_do_it/widgets/label.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onSubmit;
  final Color color;

  const PrimaryButton({
    required this.text,
    required this.onSubmit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          textStyle: const TextStyle(
            fontSize: 14,
            color: Palette.white,
          ),
          shape: const StadiumBorder(),
        ),
        onPressed: onSubmit,
        child: Label(
          text: text.toUpperCase(),
          color: Palette.white,
        ),
      ),
    );
  }
}
