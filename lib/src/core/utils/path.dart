import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> getDirectory() async{
  Directory directory = await getApplicationDocumentsDirectory();
  String path = directory.path;
  return path;
}