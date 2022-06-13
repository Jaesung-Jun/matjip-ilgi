import 'package:flutter/material.dart';
import 'widgets/input_restaurant_info_widgets.dart';
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

    InputRestaurantInfoWidgets widgets = InputRestaurantInfoWidgets();

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
              child: widgets.carouselImageSlider(),
            ),
            Row(
              children: <Widget>[
                widgets.restaurantInputTexts("날짜"),
                widgets.dateTexts(widget.date, 10.0),
              ],
            ),
            Row(
              children: <Widget>[
                widgets.restaurantInputTexts("제목"),
                widgets.titleTextBox("일기 제목", "일기의 제목을 입력해주세요.", 300, 10.0, setState),
              ],
            ),
            Row(
              children: <Widget>[
                widgets.restaurantInputTexts("평점"),
                widgets.restaurantStars(context, 10.0),
              ],
            ),
            Row(
              children: <Widget>[
                widgets.restaurantInputTexts("위치"),
                widgets.positionTextBox("위치", "", 230, 10.0, setState),
                widgets.mapAPIButton(),
              ],
            ),
            Row(
              children: <Widget>[
                widgets.restaurantInputTexts("일기\n\n\n\n\n\n\n\n\n\n"),
                widgets.diaryTextBox("", "", 300, 10.0, setState),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widgets.saveButton(context),
              ],
            )
          ],
        ),
      )
    );
  }
}