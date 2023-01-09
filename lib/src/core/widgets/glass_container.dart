import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorphic extends StatelessWidget {
  const GlassMorphic({
    Key? key,
    required this.mode,
    required this.border,
    required this.height,
    required this.width,
    this.borderWidth,
    this.child,
    this.boxShadow,
    this.margin, required this.borderColor
  }) : super(key: key);

  final ThemeMode mode;
  final BorderRadiusGeometry border;
  final double height;
  final double width;
  final double? borderWidth;
  final Widget? child;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? margin;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    bool themeChecker = mode == ThemeMode.dark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 15,
          sigmaY: 15,
        ),
        child: Container(
          height: height,
          width: width,
          margin: margin,
          decoration: BoxDecoration(
            // backgroundBlendMode: BlendMode.lighten,
            borderRadius: border,
            boxShadow: boxShadow,
            border: Border.all(
              width: borderWidth ?? 0,
              color: borderColor,
            ),
            color: themeChecker
                ?  const Color(0xff1f3341).withOpacity(0.45)
                : Colors.black.withOpacity(0.1),

          ),
          child: child,
        ),
      ),
    );
  }
}
