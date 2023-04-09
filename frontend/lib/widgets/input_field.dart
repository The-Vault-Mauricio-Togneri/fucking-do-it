import 'package:flutter/material.dart';
import 'package:fucking_do_it/utils/localizations.dart';
import 'package:fucking_do_it/utils/palette.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType inputType;
  final bool canBeEmpty;
  final bool enabled;
  final TextAlign textAlign;
  final bool autofocus;
  final FocusNode? focusNode;
  final VoidCallback? onPressed;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final Widget? suffixIcon;
  final String? inputValidator;
  final int? minLines;
  final int? maxLines;

  const InputField({
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    this.canBeEmpty = false,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.focusNode,
    this.onPressed,
    this.onChanged,
    this.onSubmit,
    this.suffixIcon,
    this.inputValidator,
    this.minLines,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
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
      onFieldSubmitted: onSubmit,
      style: const TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        hintText:
            '$label${canBeEmpty ? ' (${Localized.get.inputOptional.toLowerCase()})' : ''}',
        suffixIcon: suffixIcon,
        errorText: inputValidator,
        focusColor: Palette.primary,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.grey, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.grey, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.grey, width: 1),
        ),
        floatingLabelStyle: const TextStyle(
          fontSize: 12,
          color: Palette.primary,
        ),
        labelStyle: const TextStyle(
          fontSize: 12,
          color: Palette.hint,
        ),
        hintStyle: const TextStyle(
          fontSize: 12,
          color: Palette.hint,
        ),
      ),
      validator: (value) {
        if (!canBeEmpty && (value == null || value.isEmpty)) {
          return Localized.get.labelCannotBeEmpty(label);
        } else {
          return null;
        }
      },
    );
  }
}
