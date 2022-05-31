import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'phone_size.dart';

double rating_ = 0;

Widget textBoxBorder(String text, double padding_value) {
  return Padding(
      padding: EdgeInsets.all(padding_value),
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
          padding: EdgeInsets.all(padding_value),
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

Widget restaurantStars(BuildContext context, double padding_value){
  return Padding(
    padding: EdgeInsets.all(padding_value),
    child: Container(
      //margin: const EdgeInsets.all(10.0),
      padding: EdgeInsets.all(2.0),
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
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating);
            rating = rating_;
          },
        )
      )
  );
}

Widget restaurantTags(BuildContext context, double padding_value){
  return Container(
    padding: EdgeInsets.all(padding_value),
    child: Container(),
  );
}

Widget restaurantTextBox(String label_text, String hint_text, double width, double padding_value){
  return Container(
      width: width,
      padding: EdgeInsets.all(padding_value),
      child:TextField(
        decoration: InputDecoration(
          labelText: label_text,
          hintText: hint_text,
          border: OutlineInputBorder(),
        ),
      ),
  );
}

Widget restaurantBigTextBox(String label_text, String hint_text, double width, double padding_value){
  return Container(
    width: width,
    padding: EdgeInsets.all(padding_value),
    child:TextField(
      decoration: InputDecoration(
        labelText: label_text,
        hintText: hint_text,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.multiline,
      minLines: 10,
      maxLines: null,
    ),
  );
}
/*
Widget titleAndInput(String text, Widget widget){
  List<Widget> widgets = [
    restaurantInputTexts(text),
    widget,
  ];
  return Row(
      children: widgets
  );
}
*/
Widget carouselImageSlider(List image_list){
  List checkNull(List image_list){
    for(var i=0;i<image_list.length;i++){
      if(image_list[i] == null){
        image_list[i] = IconButton(
            onPressed: () => {},
            icon: Icon(Icons.image),
        );
      }
    }
    return image_list;
  };
  image_list = checkNull(image_list);
  return CarouselSlider(
    options: CarouselOptions(height: 400.0),
    items: [0,1,2,3,4].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: getPhoneSize(context).width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: image_list[i],
          );
        },
      );
    }).toList(),
  );
}

Widget saveButton(){
  return Container(
      child: OutlinedButton(
        onPressed: () =>{
        },
        child: Text("저장!"),
      ),
  );
}

Widget mapAPIButton(){
  return Container(
    child: OutlinedButton(
      onPressed: () =>{
      },
      child: Text("지도"),
    )
  );
}


double getStarRating(){
  return rating_;
}
