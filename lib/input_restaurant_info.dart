import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'phone_size.dart';
import 'widgets.dart';
import 'restaurant_tag.dart';

class InputRestaurantInformationPage extends StatefulWidget {
  const InputRestaurantInformationPage({Key? key}) : super(key: key);

  @override
  State<InputRestaurantInformationPage> createState() => _InputRestaurantInformationPageState();
}

class _InputRestaurantInformationPageState extends State<InputRestaurantInformationPage> {
  // 이미지 불러오기
  Future<void> loadImage() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) cropImage(image.path);
  }

// 이미지 자르기
  Future<void> cropImage(String imagePath) async {
    const MAX_WIDTH = 1920;
    const MAX_HEIGHT = 1080;
    const COMPRESS_QUALITY = 75;

    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imagePath, // 이미지 경로
        maxWidth: MAX_WIDTH, // 이미지 최대 너비
        maxHeight: MAX_HEIGHT, // 이미지 최대 높이

        compressQuality: COMPRESS_QUALITY // 이미지 압축 품질
    );
    //if(croppedImage != null) uploadImage(croppedImage.path!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: ListBody(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CarouselSlider(
                options: CarouselOptions(height: 400.0),
                items: [1,2,3,4,5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: getPhoneSize(context).width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            'text $i',
                            style: TextStyle(fontSize: 16.0),
                          ),
                      );
                    },
                  );
                }).toList(),
              )
            ),
            Row(
              children: <Widget>[
                restaurantInputTexts("날짜"),
                restaurantTexts("{selected_date}", 10.0),
              ],
            ),
            Row(
              children: <Widget>[
                restaurantInputTexts("일기\n제목"),
                restaurantTextBox("일기 제목", "일기의 제목을 입력해주세요.", 300, 10.0),
              ],
            ),
            Row(
              children: <Widget>[
                restaurantInputTexts("평점"),
                restaurantStars(context, 10.0),
              ],
            ),
            Row(
              children: <Widget>[
                restaurantInputTexts("위치"),
                restaurantTextBox("위치", "", 300, 10.0),
              ],
            ),
            Row(
              children: <Widget>[
                restaurantInputTexts("일기\n\n\n\n\n\n\n\n\n\n"),
                restaurantBigTextBox("", "", 300, 10.0),
              ],
            )
          ],
        ),
      )
    );
  }
}