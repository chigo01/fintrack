import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Animation<double> useLinearProgress(double value) {
  final animationController = useAnimationController(
    duration: const Duration(seconds: 7),
  );
  useEffect(() {
    animationController.forward();
    return null;
  }, const []);

  useAnimation(animationController);
  return Tween<double>(begin: 3, end: value).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.fastLinearToSlowEaseIn,
    ),
  );
}
