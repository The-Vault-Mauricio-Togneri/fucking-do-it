import 'package:flutter/material.dart';
import 'package:fucking_do_it/utils/localizations.dart';
import 'package:fucking_do_it/utils/palette.dart';

class CommentInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onSubmit;

  const CommentInput({
    required this.controller,
    required this.focusNode,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      autofocus: true,
      keyboardType: TextInputType.text,
      minLines: 1,
      maxLines: 1,
      textCapitalization: TextCapitalization.sentences,
      onFieldSubmitted: onSubmit,
      style: const TextStyle(
        color: Palette.black,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        hintText: Localized.get.inputComment,
        focusColor: Palette.primary,
        fillColor: Palette.inputBackground,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.inputBackground, width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.inputBackground, width: 0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.inputBackground, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.inputBackground, width: 0),
        ),
        hintStyle: const TextStyle(
          fontSize: 12,
          color: Palette.hint,
        ),
      ),
    );
  }
}
