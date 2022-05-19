import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'constants.dart';
import 'input_restaurant_info.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_INFO,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MainPage> {
  var _index = 0;

  void isDiaryWrote(CalendarTapDetails){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InputRestaurantInformationPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Constants.APP_NAME,
          textAlign: TextAlign.left,
        ),
        actions: <Widget>[
          new IconButton(
              onPressed: () => {},
              tooltip: '메뉴',
              icon: Icon(Icons.menu),
          )
        ],
      ),
      body:
        Row(
            children: <Widget>[
              SfCalendar(
                  view: CalendarView.month,
                  firstDayOfWeek: 1,
                  onTap: isDiaryWrote,
              ),
            ]
        ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: '캘린더로 보기',
            icon: Icon(Icons.calendar_month),
          ),
          BottomNavigationBarItem(
            label: '일기별로 보기',
            icon: Icon(Icons.calendar_view_day_outlined),
          ),
        ],
      ),
    );
  }
}
