import 'package:flutter/material.dart';
import 'package:fucking_do_it/utils/palette.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onSubmit;

  const PrimaryButton({
    required this.text,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.primary,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          textStyle: const TextStyle(
            fontSize: 14,
            color: Palette.white,
          ),
          shape: const StadiumBorder(),
        ),
        onPressed: onSubmit,
        child: Text(text),
      ),
    );
  }
}
