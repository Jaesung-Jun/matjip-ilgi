import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantInfo{
  static double rating = 3.0;
  static List<dynamic> imageList = List.filled(5, null);
  static String titleText = "";
  static GeoPoint restaurantPosition = const GeoPoint(77.0, 77.0);
  static String diary = "";
  static String date = "";
  static String address = "";

  static void initialize(){
    //Initialize.
    rating = 3.0;
    imageList = List.filled(5, null);
    titleText = "";
    restaurantPosition = const GeoPoint(77.0, 77.0);
    diary = "";
    date = "";
    address = "";
  }
}