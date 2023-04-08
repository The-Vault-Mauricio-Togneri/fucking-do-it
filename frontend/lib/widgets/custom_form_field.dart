import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType inputType;
  final bool canBeEmpty;
  final bool enabled;
  final TextAlign textAlign;
  final bool autofocus;
  final VoidCallback? onPressed;
  final Function(String)? onChanged;
  final String? suffixText;
  final String? inputValidator;
  final int? minLines;
  final int? maxLines;

  const CustomFormField({
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    this.canBeEmpty = false,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.onPressed,
    this.onChanged,
    this.suffixText,
    this.inputValidator,
    this.minLines,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: textAlign,
      controller: controller,
      readOnly: !enabled,
      onTap: onPressed,
      autofocus: autofocus,
      obscureText: isPassword,
      keyboardType: inputType,
      minLines: minLines,
      maxLines: maxLines,
      textCapitalization: TextCapitalization.sentences,
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        suffixText: suffixText,
        errorText: inputValidator,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        labelStyle: const TextStyle(
          fontSize: 12,
        ),
        hintStyle: const TextStyle(
          fontSize: 12,
        ),
      ),
      validator: (value) {
        if (!canBeEmpty && (value == null || value.isEmpty)) {
          return '$label cannot be empty';
        }
        return null;
      },
    );
  }
}
