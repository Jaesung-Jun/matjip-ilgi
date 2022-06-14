import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

String convertBase64(String imagePath){
  final bytes = File(imagePath).readAsBytesSync();
  String base64Image = base64Encode(bytes);
  return base64Image;
}

Uint8List base64ToImage(String base64Str) {
  Uint8List bytes = base64.decode(base64Str);
  return bytes;
}