import 'package:flutter/material.dart';
import 'widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class InputRestaurantInformationPage extends StatefulWidget {
  final String date;
  const InputRestaurantInformationPage({Key? key, @required this.date=""}) : super(key: key);
  @override
  State<InputRestaurantInformationPage> createState() => _InputRestaurantInformationPageState();
}

class _InputRestaurantInformationPageState extends State<InputRestaurantInformationPage> {
  // 이미지 불러오기
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      //print(widget.date);
      //print(getDataFromFirebase(widget.date, "date"));
    });

    () async {
      var _permissionStatus = await Permission.storage.status;

      if (_permissionStatus != PermissionStatus.granted) {
        PermissionStatus permissionStatus= await Permission.storage.request();
        setState(() {
          _permissionStatus = permissionStatus;
        });
      }
    } ();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: ListBody(
          //mainAxisAlignment: MainAxisAlignment.start,i
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: carouselImageSlider(),
            ),
            Row(
              children: <Widget>[
                restaurantInputTexts("날짜"),
                dateTexts(widget.date, 10.0),
              ],
            ),
            Row(
              children: <Widget>[
                restaurantInputTexts("제목"),
                titleTextBox("일기 제목", "일기의 제목을 입력해주세요.", 300, 10.0, setState),
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
                positionTextBox("위치", "", 230, 10.0, setState),
                mapAPIButton(),
              ],
            ),
            Row(
              children: <Widget>[
                restaurantInputTexts("일기\n\n\n\n\n\n\n\n\n\n"),
                diaryTextBox("", "", 300, 10.0, setState),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                saveButton(context),
              ],
            )
          ],
        ),
      )
    );
  }
}