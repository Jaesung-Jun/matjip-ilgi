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
      "restaurantPosition": const GeoPoint(33, 33),
      "restaurantStars": 3,
      "title": "",
    });
    print("생성!");
  }else{
    print("이미 존재!");
  }
}