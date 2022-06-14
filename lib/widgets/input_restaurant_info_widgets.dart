import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:matjip_ilgi/input_restaurant_info.dart';
import 'package:matjip_ilgi/widgets/restaurant_infos.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/phone_size.dart';
import '../utils/image_convert.dart';
import '../utils/get_send_data.dart';
import './restaurant_widgets.dart';
import 'package:kpostal/kpostal.dart';

import 'dart:io';

class InputRestaurantInfoWidgets extends RestaurantWidgets{

  @override
  Widget carouselImageSlider(Function setState, List<dynamic> sliderWidgetList) {

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
      if (croppedImage != null) {
        sliderWidgetList[i] = Image.file(File(croppedImage.path));
        RestaurantInfo.imageList[i] = convertBase64(croppedImage.path);
      } else {
        sliderWidgetList[i] = Image.file(File(imagePath));
        RestaurantInfo.imageList[i] = convertBase64(imagePath);
        //imageList_[i] = imagePath;
      }
      setState(() {});
    }

    Future<void> loadImage(int i) async {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        cropImage(image.path, i);
      }
    }

    List initializeSlider(List sliderWidgetList) {
      for (var i = 0; i < sliderWidgetList.length; i++) {
        if (sliderWidgetList[i] == null) {
          sliderWidgetList[i] = IconButton(
            onPressed: () => loadImage(i),
            icon: const Icon(Icons.image),
          );
        }
        //RestaurantInfo.imageList[i] = null;
      }
      return sliderWidgetList;
    }
    sliderWidgetList = initializeSlider(sliderWidgetList);
    return CarouselSlider(
      items: [0, 1, 2, 3, 4].map((i) {
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

  @override
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

  @override
  Widget restaurantStars(BuildContext context, double initialRating, double paddingValue, Function setState) {
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
              initialRating: initialRating,
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
                RestaurantInfo.rating = rating;
              },
            )
        )
    );
  }

  @override
  Widget restaurantTags(BuildContext context, double paddingValue){
    return Container(
      padding: EdgeInsets.all(paddingValue),
      child: Container(),
    );
  }

  Widget saveButton(BuildContext context, InputRestaurantInformationPage widget){
    return OutlinedButton(
      onPressed: () async => {
        await addNecessaryDataToFirebase(RestaurantInfo.date),
        await updateDataToFirebase(RestaurantInfo.date, "diary", RestaurantInfo.diary),
        await updateDataToFirebase(RestaurantInfo.date, "images", RestaurantInfo.imageList),
        await updateDataToFirebase(RestaurantInfo.date, "restaurantPosition", RestaurantInfo.restaurantPosition),
        await updateDataToFirebase(RestaurantInfo.date, "restaurantStars", RestaurantInfo.rating),
        await updateDataToFirebase(RestaurantInfo.date, "title", RestaurantInfo.titleText),
        await updateDataToFirebase(RestaurantInfo.date, "address", RestaurantInfo.address),

        print(RestaurantInfo.date),
        print(RestaurantInfo.diary),
        print(RestaurantInfo.imageList),
        print(RestaurantInfo.restaurantPosition),
        print(RestaurantInfo.rating),
        print(RestaurantInfo.titleText),

        widget.refreshParent(),
        RestaurantInfo.initialize(),
        Navigator.pop(context),
      },
      child: const Text("저장!"),
    );
  }

  Widget mapAPIButton(BuildContext context, Function setState) {

    String sliceString(String str){
      if(str.length > 18){
        str = str.substring(0, 16);
        str = str + "...";
      }
      return str;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Padding(
          padding: EdgeInsets.only(left:10.0),
          child: OutlinedButton(
            onPressed: () async {
              Kpostal result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => KpostalView(
                        useLocalServer:false,
                      )
                  )
              );
              RestaurantInfo.address = result.address;
              RestaurantInfo.restaurantPosition = GeoPoint(result.latitude!, result.longitude!);

              setState(() {});
            },
            child: Text("[주소 찾기] " + sliceString(RestaurantInfo.address)),
          )
        ),
      ]
    );
  }
}