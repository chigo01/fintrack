import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    required this.hintText,
    this.hintStyle,
    required this.filled,
    required this.border,
    this.suffixIcon,
    this.keyboardType,
    this.focusedBorder,
    this.constraints,
    this.style,
    this.prefix,
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
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefix: prefix,
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
