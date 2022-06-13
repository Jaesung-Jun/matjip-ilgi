import 'package:flutter/material.dart';
import 'restaurant_widgets.dart';

class ShowRestaurantInfoWidgets extends RestaurantWidgets {

  @override
  Widget titleTextBox(String labelText, String hintText, double width, double paddingValue, Function setState){
    return Container(
      width: width,
      padding: EdgeInsets.all(paddingValue),
      child:TextField(
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: const OutlineInputBorder(),
          enabled: false,
        ),
      ),
    );
  }
}