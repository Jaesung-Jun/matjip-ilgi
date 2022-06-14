import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:matjip_ilgi/show_restaurant_info.dart';
import '../utils/image_convert.dart';
import '../utils/phone_size.dart';
import 'restaurant_widgets.dart';

class ShowRestaurantInfoWidgets extends RestaurantWidgets {

  Future<Widget> carouselImageShowSlider(List<dynamic> imageListBase64) async {
    int numImage = 0;
    List<dynamic> sliderWidgetList = List.filled(5, null);

    for(var i=0;i< sliderWidgetList.length;i++){
      if(imageListBase64[i] != null){
        numImage++;
        sliderWidgetList[i] = Image.memory(base64ToImage(imageListBase64[i]));
      }else{
        break;
      }
    }
    if(numImage == 0){
      return Padding(
        padding: EdgeInsets.all(20),
      );
    }
    return CarouselSlider(
      items: List.generate(numImage, (i) => i).map((j) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: getPhoneSize(context).width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: sliderWidgetList[j],
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: 400.0,
      ),
    );
  }

  @override
  Widget titleTextBox(String labelText, String hintText, double width, double paddingValue){
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
  @override
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
        keyboardType: TextInputType.multiline,
        minLines: 10,
        maxLines: null,
        enabled: false,
      ),
    );
  }
  @override
  Widget restaurantStars(BuildContext context, double initialRating, double paddingValue, Function setState){
    double defaultRating = initialRating;
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
              initialRating: defaultRating,
              minRating: 0.5,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating){},
            )
        )
    );
  }
  @override
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
        enabled: false,
        onChanged: (text) {
        },
      ),
    );
  }

  Widget backButton(BuildContext context, ShowRestaurantInformationPage widget){
    return OutlinedButton(
      onPressed: () async => {
        widget.refreshParent(),
        Navigator.pop(context),
      },
      child: const Text("뒤로가기"),
    );
  }

}