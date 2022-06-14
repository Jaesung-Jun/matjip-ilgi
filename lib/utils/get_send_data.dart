import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


Future<dynamic> getDataFromFirebase(String date, String field) async {
  dynamic data;
  await FirebaseFirestore.instance.collection("matjip_ilgi").doc(date).get().then((DocumentSnapshot ds){
    data = ds.data()?[field];
    //print(data);
  });
  return data;
}
Future<List<dynamic>> getAllDatesFromFirebase() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("matjip_ilgi").get();
  var list = querySnapshot.docs;
  var listByDate = [];
  List<String> dateList = List.filled(list.length, "");
  for(var i=0;i<list.length;i++){
    dateList[i] = list[i].data()?["date"];
  }
  return dateList;
}

Future<void> updateDataToFirebase(String date, String field, dynamic updateValue) async {
  FirebaseFirestore.instance.collection("matjip_ilgi").doc(date).update({
    field: updateValue,
  });
}
/*
void addDataToFirebase(String fieldName, dynamic data){
  FirebaseFirestore.instance.collection("matjip_ilgi").doc(date).set({
    fieldName: data
  });
}*/

Future<void> addNecessaryDataToFirebase(String date) async {

  var tmp = await getDataFromFirebase(date, "date");
  if(tmp == null){
    FirebaseFirestore.instance.collection("matjip_ilgi").doc(date).set({
      "date": date,
      "diary": "",
      "images": [null,null,null,null,null],
      "address": "",
      "restaurantPosition": const GeoPoint(33, 33),
      "restaurantStars": 3,
      "title": "",
    });
    //print("생성!");
  }else{
    //print("이미 존재!");
  }
}