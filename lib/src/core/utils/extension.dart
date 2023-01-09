import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext {
  double getHeight([double height = 1]) {
    assert(height != 0);
    return MediaQuery.of(this).size.height * height;
  }

  double getWidth([double width = 1]) {
    assert(width != 0);
    return MediaQuery.of(this).size.width * width;
  }

  double get height => getHeight();
  double get width => getWidth();
}


