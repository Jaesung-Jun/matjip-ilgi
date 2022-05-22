import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets.dart';

class InputRestaurantInformationPage extends StatelessWidget {
  const InputRestaurantInformationPage({Key? key}) : super(key: key);

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Padding(
                padding: EdgeInsets.fromLTRB(8, 150, 8, 150),
                child: IconButton(
                  icon: Icon(Icons.image),
                  iconSize: 50,
                  onPressed: loadImage,
                )
            ),
          ),
          titleAndInput("날짜", restaurantTexts("{SelectedDate}", 20.0))
        ],
      ),
    );
  }
}