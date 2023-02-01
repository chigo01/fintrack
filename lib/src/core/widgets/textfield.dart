import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    required this.hintText,
    this.hintStyle,
    required this.filled,
    required this.border,
   required this.controller,
    this.suffixIcon,
    this.keyboardType,
    this.focusedBorder,
    this.constraints,
    this.style,
    this.prefixText,
    this.prefixStyle,
  }) : super(key: key);

  final String hintText;
  final TextStyle? hintStyle;
  final bool? filled;
  final InputBorder? border;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final InputBorder? focusedBorder;
  final BoxConstraints? constraints;
  final TextStyle? style;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: style,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixText: prefixText,
        prefixStyle: prefixStyle,
        hintText: hintText,
        filled: filled,
        constraints: constraints,
        suffixIcon: suffixIcon,
        focusedBorder: focusedBorder,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 15,
              color: Colors.grey,
            ),
        // filled: true,
        border: border,
      ),
    );
  }
}
