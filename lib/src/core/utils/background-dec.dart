import 'package:flutter/material.dart';

BoxDecoration backgroundColor() {
  return const BoxDecoration(
    backgroundBlendMode: BlendMode.srcOver,
    gradient: LinearGradient(

      colors: [
        Color(0xff130F1A),
        Color(0xff162D33),
        Color(0xff130F1A),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomLeft,
      stops: [0, 0.6, 1],

    ),
  );
}
