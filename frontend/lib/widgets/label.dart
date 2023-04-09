import 'package:flutter/material.dart';
import 'package:fucking_do_it/utils/constants.dart';

class Label extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight weight;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;

  const Label({
    required this.text,
    required this.color,
    this.size = 14,
    this.weight = FontWeight.normal,
    this.align,
    this.maxLines,
    this.overflow,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: size / 20),
      child: Text(
        text,
        maxLines: maxLines,
        textAlign: align,
        overflow: overflow,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: weight,
          decoration: decoration,
          fontFamily: Constants.FONT_NAME,
        ),
      ),
    );
  }
}
