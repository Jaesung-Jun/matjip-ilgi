import 'package:flutter/material.dart';
import 'package:matjip_ilgi/widgets/restaurant_infos.dart';
import 'widgets/input_restaurant_info_widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class InputRestaurantInformationPage extends StatefulWidget {
  const InputRestaurantInformationPage({Key? key, this.date="", required this.refreshParent}) : super(key: key);
  final String date;
  final Function refreshParent;
  @override
  State<InputRestaurantInformationPage> createState() => _InputRestaurantInformationPageState();
}

class _InputRestaurantInformationPageState extends State<InputRestaurantInformationPage> {

  List<dynamic> sliderWidgetList = List.filled(5, null);

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RestaurantInfo.date = widget.date;
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
  void dispose(){
    super.dispose();
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
              child: widgets.carouselImageSlider(setState, sliderWidgetList),
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
                widgets.titleTextBox("일기 제목", "일기의 제목을 입력해주세요.", 300, 10.0),
              ],
            ),
            Row(
              children: <Widget>[
                widgets.restaurantInputTexts("평점"),
                widgets.restaurantStars(context, 3.0, 10.0, setState),
              ],
            ),
            Row(
              children: <Widget>[
                widgets.restaurantInputTexts("주소"),
                //widgets.positionTextBox("위치", RestaurantInfo.address, 230, 10.0),
                widgets.mapAPIButton(context, setState),
              ],
            ),
            Row(
              children: <Widget>[
                widgets.restaurantInputTexts("일기\n\n\n\n\n\n\n\n\n\n"),
                widgets.diaryTextBox("", "", 300, 10.0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widgets.saveButton(context, widget),
              ],
            )
          ],
        ),
      )
    );
  }
}