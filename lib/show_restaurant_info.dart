import 'package:flutter/material.dart';
import 'package:matjip_ilgi/widgets/show_restaurant_info_widgets.dart';

class ShowRestaurantInformationPage extends StatefulWidget {

  const ShowRestaurantInformationPage({Key? key, required this.restaurantInfo}) : super(key: key);
  final Map restaurantInfo;

  @override
  State<ShowRestaurantInformationPage> createState() => _ShowRestaurantInformationPageState();
}

class _ShowRestaurantInformationPageState extends State<ShowRestaurantInformationPage> {
  ShowRestaurantInfoWidgets widgets = ShowRestaurantInfoWidgets();
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
              child: widgets.carouselImageSlider(),
            ),
            Row(
              children: <Widget>[
                widgets.restaurantInputTexts("날짜"),
                widgets.dateTexts(widget.restaurantInfo['date'], 10.0),
              ],
            ),
            Row(
              children: <Widget>[
                widgets.restaurantInputTexts("제목"),
                widgets.titleTextBox(widget.restaurantInfo['title'], "", 300, 10.0, setState),
              ],
            ),
            Row(
              children: <Widget>[
                widgets.restaurantInputTexts("평점"),
                //widgets.restaurantStars(context, 10.0),
              ],
            ),
            Row(
              children: <Widget>[
                widgets.restaurantInputTexts("위치"),
                //widgets.positionTextBox("위치", "", 230, 10.0, setState),
                //widgets.mapAPIButton(),
              ],
            ),
            Row(
              children: <Widget>[
                widgets.restaurantInputTexts("일기\n\n\n\n\n\n\n\n\n\n"),
                //widgets.diaryTextBox("", "", 300, 10.0, setState),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //widgets.saveButton(context),
              ],
            )
          ],
        ),
      ),
    );
  }
}
