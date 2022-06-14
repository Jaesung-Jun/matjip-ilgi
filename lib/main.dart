import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:firebase_core/firebase_core.dart';

import 'constants.dart';
import 'input_restaurant_info.dart';
import 'utils/get_send_data.dart';
import 'show_restaurant_info.dart';

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

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
    final String formattedDate = formatter.format(date);
    var getDate = await getDataFromFirebase(formattedDate, "date");
    bool isExists = (getDate != null) ? true : false;
    if(!isExists){
      //입력화면
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InputRestaurantInformationPage(date: formattedDate, refreshParent: refresh))
      );
    }else{
      Map restaurantInfo = {
        'date': await getDataFromFirebase(formattedDate, "date"),
        'diary': await getDataFromFirebase(formattedDate, "diary"),
        "images": await getDataFromFirebase(formattedDate, "images"),
        "restaurantPosition": await getDataFromFirebase(formattedDate, "restaurantPosition"),
        "restaurantStars": await getDataFromFirebase(formattedDate, "restaurantStars"),
        "title": await getDataFromFirebase(formattedDate, "title"),
        "address": await getDataFromFirebase(formattedDate, "address"),
      };
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShowRestaurantInformationPage(restaurantInfo: restaurantInfo, refreshParent: refresh))
      );
    }
  }
  _AppointmentDataSource _getCalendarDataSource(List dateList) {
    List<Appointment> appointments = <Appointment>[];
    for(int i=0;i<dateList.length;i++){
      DateTime parsedDate = DateTime.parse(dateList[i]);
      appointments.add(Appointment(
        startTime: parsedDate,
        endTime: parsedDate,
        subject: '*',
        color: Colors.redAccent,
      ));
    }
    /*
    appointments.add(Appointment(
      startTime: DateTime(2022, 06, 14, 10),
      endTime: DateTime(2022, 06, 14, 12),
      subject: 'Occurs daily',
      color: Colors.red,));
    */
    print(appointments.length);
    return _AppointmentDataSource(appointments);
    return _AppointmentDataSource(appointments);
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.APP_INFO,
          textAlign: TextAlign.left,
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () => {},
              tooltip: '메뉴',
              icon: const Icon(Icons.menu),
          )
        ],
      ),
      body:
        Row(
            children: <Widget>[
              FutureBuilder(
                  future: getAllDatesFromFirebase(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.data != null){
                      return SfCalendar(
                        view: CalendarView.month,
                        firstDayOfWeek: 1,
                        onTap: isDiaryWrote,
                        dataSource: _getCalendarDataSource(snapshot.data),
                        monthViewSettings: const MonthViewSettings(
                          showAgenda: true,
                          appointmentDisplayCount: 3,
                          agendaViewHeight: 100,
                        ),
                      );
                    }else{
                      return Container();
                    }
                  }
              )
            ]
        ),
      /*
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: '캘린더로 보기',
            icon: Icon(Icons.calendar_month),
          ),
          BottomNavigationBarItem(
            label: '일기별로 보기',
            icon: Icon(Icons.calendar_view_day_outlined),
          ),
        ],
      ),*/
    );
  }
}
