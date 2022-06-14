import 'package:flutter/material.dart';
import 'widgets/show_restaurant_info_widgets.dart';

class ShowRestaurantInformationPage extends StatefulWidget {

  const ShowRestaurantInformationPage({Key? key, required this.restaurantInfo, required this.refreshParent}) : super(key: key);
  final Function refreshParent;
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
            Container(
              child: FutureBuilder(
                  future: widgets.carouselImageShowSlider(widget.restaurantInfo['images']),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(snapshot.hasData == false){
                      return const Padding(
                        padding: EdgeInsets.all(162.0),
                        child: CircularProgressIndicator(strokeWidth: 5),
                      );
                    }else if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(fontSize: 15),
                        ),
                      );
                    }else{
                      return Center(
                        child: snapshot.data,
                      );
                    }
                  },
              ),
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
                widgets.titleTextBox(widget.restaurantInfo['title'], "", 300, 10.0),
              ],
            ),
            Row(
              children: <Widget>[
                widgets.restaurantInputTexts("평점"),
                widgets.restaurantStars(context, widget.restaurantInfo['restaurantStars'], 10.0, setState),
              ],
            ),
            Row(
              children: <Widget>[
                widgets.restaurantInputTexts("주소"),
                widgets.positionTextBox(widget.restaurantInfo['address'], "", 300, 10.0),
              ],
            ),
            Row(
              children: <Widget>[
                widgets.restaurantInputTexts("일기\n\n\n\n\n\n\n\n\n\n"),
                widgets.diaryTextBox(widget.restaurantInfo['diary'], "", 300, 10.0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widgets.backButton(context, widget),
              ],
            )
          ],
        ),
      ),
    );
  }
}
