import 'package:flutter/material.dart';
import 'restaurant_infos.dart';

class RestaurantWidgets{

  Widget restaurantStars(BuildContext context, double initialRating, double paddingValue, Function setState) {
    return Container();
  }
  Widget carouselImageSlider(Function setState, List<dynamic> sliderWidgetList){
    return Container();
  }
  Widget restaurantTags(BuildContext context, double paddingValue){
    return Container();
  }
  Widget textBoxBorder(String text, double paddingValue){
    return Container();
  }

  Widget dateTexts(String text, double paddingValue){
    RestaurantInfo.date = text;
    return Padding(
        padding: EdgeInsets.all(paddingValue),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15.0,
          ),
          textAlign: TextAlign.center,
        )
    );
  }
  Widget restaurantInputTexts(String text){
    return Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        )
    );
  }
  Widget titleTextBox(String labelText, String hintText, double width, double paddingValue){
    return Container(
      width: width,
      padding: EdgeInsets.all(paddingValue),
      child:TextField(
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        onChanged: (text) {
          RestaurantInfo.titleText = text;
        },
      ),
    );
  }
  Widget diaryTextBox(String labelText, String hintText, double width, double paddingValue){
    return Container(
      width: width,
      padding: EdgeInsets.all(paddingValue),
      child:TextField(
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        onChanged: (text) {
          RestaurantInfo.diary = text;
        },
        keyboardType: TextInputType.multiline,
        minLines: 10,
        maxLines: null,
      ),
    );
  }
  Widget positionTextBox(String labelText, String hintText, double width, double paddingValue){
    return Container(
      width: width,
      padding: EdgeInsets.all(paddingValue),
      child:TextField(
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        onChanged: (text) {
        },
      ),
    );
  }

}