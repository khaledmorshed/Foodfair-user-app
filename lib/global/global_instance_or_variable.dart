import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sPref;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
String? sellerUIDD;
String previousSellerId = '';
final sliderItems = [
  "slider/0.jpg",
  "slider/1.jpg",
  "slider/2.jpg",
  "slider/3.jpg",
  "slider/4.jpg",
  "slider/5.jpg",
  "slider/6.jpg",
  "slider/7.jpg",
  "slider/8.jpg",
  "slider/9.jpg",
  "slider/10.jpg",
  "slider/11.jpg",
  "slider/12.jpg",
  "slider/13.jpg",
  "slider/14.jpg",
  "slider/15.jpg",
  "slider/16.jpg",
  "slider/17.jpg",
  "slider/18.jpg",
  "slider/19.jpg",
  "slider/20.jpg",
  "slider/21.jpg",
  "slider/22.jpg",
  "slider/23.jpg",
  "slider/24.jpg",
  "slider/25.jpg",
  "slider/26.jpg",
  "slider/27.jpg",
];