import 'package:flutter/material.dart';

Size getPhoneSize(BuildContext context){
  final size = MediaQuery.of(context).size;
  return size;
}