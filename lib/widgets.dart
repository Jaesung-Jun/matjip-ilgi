import 'package:flutter/material.dart';

Widget textBoxBorder(String text, double padding_value) {
  return Padding(
      padding: EdgeInsets.only(left: padding_value),
      child: Container(
        //margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all()
        ), //             <--- BoxDecoration here
        child: Text(
          text,
          style: TextStyle(fontSize: 15.0),
          textAlign: TextAlign.center,
        ),
      ),
  );
}

Widget restaurantTexts(String text, double padding_value){
  return Container(
      child: Padding(
          padding: EdgeInsets.only(left: padding_value),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15.0,
            ),
            textAlign: TextAlign.center,
          )
      )
  );
}

Widget restaurantInputTexts(String text) {
  return Container(
    child: Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        )
    )
  );
}

Widget restaurantStars(int stars, double padding_value){
  return Container(
    child: Padding(
      padding: EdgeInsets.only(left: padding_value),
      child:
    )
  )
}

Widget titleAndInput(String text, Widget widget){
  List<Widget> widgets = [
    restaurantInputTexts(text),
    widget,
  ];
  return Row(
      children: widgets
  );
}
