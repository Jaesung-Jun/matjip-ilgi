import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:firebase_core/firebase_core.dart';

import 'constants.dart';
import 'input_restaurant_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'get_send_data.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

  void isDiaryWrote(CalendarTapDetails details) async {
    DateTime date = details.date!;
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formatted_date = formatter.format(date);

    var getDate = await getDataFromFirebase(formatted_date, "date");
    bool isExists = (getDate != null) ? true : false;
    if(!isExists){
      //입력화면
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InputRestaurantInformationPage(date: formatted_date))
      );
    }else{
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InputRestaurantInformationPage(date: formatted_date))
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Constants.APP_INFO,
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
                  monthViewSettings: MonthViewSettings(
                      showAgenda: true,
                      appointmentDisplayCount: 3,
                      agendaViewHeight: 100,
                  ),
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
