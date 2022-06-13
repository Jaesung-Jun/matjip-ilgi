import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'phone_size.dart';
import 'image_convert.dart';
import 'get_send_data.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

double rating_ = 3.0;
List<dynamic> imageList_ = List.filled(5, null);
String titleText_ = "";
GeoPoint restaurantPosition_ = const GeoPoint(77.0, 77.0);
String diary_ = "";
String date_ = "";

Widget textBoxBorder(String text, double paddingValue) {
  return Padding(
      padding: EdgeInsets.all(paddingValue),
      child: Container(
        //margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all()
        ), //             <--- BoxDecoration here
        child: Text(
          text,
          style: const TextStyle(fontSize: 15.0),
          textAlign: TextAlign.center,
        ),
      ),
  );
}

Widget dateTexts(String text, double paddingValue){
  date_ = text;
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

Widget restaurantInputTexts(String text) {
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

Widget titleTextBox(String labelText, String hintText, double width, double paddingValue, Function setState){
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
          setState(() {
            titleText_ = text;
          });
        },
      ),
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

//Diary
Widget diaryTextBox(String labelText, String hintText, double width, double paddingValue, Function setState){
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
        setState(() {
          diary_ = text;
        });
      },
      keyboardType: TextInputType.multiline,
      minLines: 10,
      maxLines: null,
    ),
  );
}

Widget carouselImageSlider(){
  // 이미지 자르기
  List<dynamic> sliderWidgetList = List.filled(5, null);
  int currentPage = 0;

  Future<void> cropImage(String imagePath, int i) async {
    const maxWidth = 1920;
    const maxHeight = 1080;
    const compressQuality = 75;

    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imagePath, // 이미지 경로
        maxWidth: maxWidth, // 이미지 최대 너비
        maxHeight: maxHeight, // 이미지 최대 높이
        compressQuality: compressQuality // 이미지 압축 품질
    );
    if(croppedImage != null){
      sliderWidgetList[i] = Image.file(File(croppedImage.path));
      imageList_[i] = convertBase64(croppedImage.path);
      //imageList_[i] = croppedImage.path;
    }else{
      sliderWidgetList[i] = Image.file(File(imagePath));
      imageList_[i] = convertBase64(imagePath);
      //imageList_[i] = imagePath;
    }
  }

  Future<void> loadImage(int i) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      cropImage(image.path, i);
    }
  }

  List initializeSlider(List sliderWidgetList){
    for(var i=0;i<sliderWidgetList.length;i++) {
      if (sliderWidgetList[i] == null) {
        sliderWidgetList[i] = IconButton(
          onPressed: () => loadImage(i),
          icon: const Icon(Icons.image),
        );
      }
      imageList_[i] = null;
    }
    return sliderWidgetList;
  }
  sliderWidgetList = initializeSlider(sliderWidgetList);

  return CarouselSlider(
    items: [0,1,2,3,4].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: getPhoneSize(context).width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            child: sliderWidgetList[i],
          );
        },
      );
    }).toList(),
    options: CarouselOptions(
      height: 400.0,
    ),
  );
}

Widget saveButton(BuildContext context){
  return Container(
      child: OutlinedButton(
        onPressed: () async => {
          await addNecessaryDataToFirebase(getDate()),
          await updateDataToFirebase(getDate(), "diary", getDiary()),
          await updateDataToFirebase(getDate(), "images", getImageList()),
          print(getImageList()),
          await updateDataToFirebase(getDate(), "restaurantPosition", getRestaurantPosition()),
          await updateDataToFirebase(getDate(), "restaurantStars", getStarRating()),
          await updateDataToFirebase(getDate(), "title", getTitleText()),
          /*
          print(getDate()),
          print(getDiary()),
          print(getImageList()),
          print(getRestaurantPosition()),
          print(getStarRating()),
          print(getTitleText()),*/
          await Future.delayed(const Duration(seconds: 1)),
          Navigator.pop(context),
        },
        child: const Text("저장!"),
      ),
  );
}

Widget mapAPIButton(){
  return Container(
    child: OutlinedButton(
      onPressed: () =>{
      },
      child: const Text("지도"),
    )
  );
}
String getDate(){
  return date_;
}

double getStarRating(){
  return rating_;
}

String getTitleText(){
  return titleText_;
}

GeoPoint getRestaurantPosition(){
  return restaurantPosition_;
}

String getDiary(){
  return diary_;
}

List<dynamic> getImageList(){
  return imageList_;
}