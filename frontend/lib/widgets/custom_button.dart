import 'package:flutter/material.dart';
import 'package:fucking_do_it/utils/palette.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color color;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.color = Palette.primary,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
