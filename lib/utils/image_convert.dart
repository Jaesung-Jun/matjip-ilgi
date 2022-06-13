import 'dart:convert';
import 'dart:io';

String convertBase64(String imagePath){
  final bytes = File(imagePath).readAsBytesSync();
  String base64Image = base64Encode(bytes);
  return base64Image;
}