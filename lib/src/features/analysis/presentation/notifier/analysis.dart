import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavigateAnalysis extends Notifier<bool> {
  @override
  build() {
    return false;
  }

  bool push() {
    state = true;
    return state;
  }

  bool pop() {
    state = false;
    return state;
  }
}
