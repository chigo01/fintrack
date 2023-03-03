import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePath = StateProvider<String?>((ref) => null);
Future<void> getImage(WidgetRef ref) async {
  final ImagePicker picker = ImagePicker();
  final pickedFile = await picker.pickImage(
    source: ImageSource.gallery,
    maxHeight: double.infinity,
    maxWidth: double.infinity,
  );

  if (pickedFile != null) {
    ref.read(imagePath.notifier).update(
          (state) => state = pickedFile.path,
        );
  }
}
