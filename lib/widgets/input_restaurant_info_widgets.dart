import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../utils/get_send_data.dart';
import 'restaurant_widgets.dart';

class InputRestaurantInfoWidgets extends RestaurantWidgets{

  Widget restaurantStars(BuildContext context, double paddingValue){
    rating_ = 3.0;
    return Padding(
        padding: EdgeInsets.all(paddingValue),
        child: Container(
          //margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.amberAccent),
              borderRadius: BorderRadius.circular(10),
            ),
            child: RatingBar.builder(
              initialRating: 3,
              minRating: 0.5,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                rating_ = rating;
              },
            )
        )
    );
  }

  Widget restaurantTags(BuildContext context, double paddingValue){
    return Container(
      padding: EdgeInsets.all(paddingValue),
      child: Container(),
    );
  }


  Widget positionTextBox(String labelText, String hintText, double width, double paddingValue, Function setState){
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

  Widget saveButton(BuildContext context){
    return OutlinedButton(
      onPressed: () async => {
        await addNecessaryDataToFirebase(getDate()),
        await updateDataToFirebase(getDate(), "diary", getDiary()),
        await updateDataToFirebase(getDate(), "images", getImageList()),
        await updateDataToFirebase(getDate(), "restaurantPosition", getRestaurantPosition()),
        await updateDataToFirebase(getDate(), "restaurantStars", getStarRating()),
        await updateDataToFirebase(getDate(), "title", getTitleText()),
        /*
        print(getDate()),
        print(getDiary()),
        print(getImageList()),
        print(getRestaurantPosition()),
        print(getStarRating()),
        print(getTitleText()),
        */
        await Future.delayed(const Duration(seconds: 1)),
        Navigator.pop(context),
      },
      child: const Text("저장!"),
    );
  }

  Widget mapAPIButton() {
    return Container(
        child: OutlinedButton(
          onPressed: () =>
          {
          },
          child: const Text("지도"),
        )
    );
  }
}