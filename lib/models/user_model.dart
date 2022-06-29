import 'package:flutter/foundation.dart';

class UserModel{
  String? userUID;
  String? userEmail;
  String? userName;
  String? userPhotoUrl;
  List<String> userCart = ['garbageValue'];

  UserModel({this.userUID, this.userEmail, this.userName, this.userPhotoUrl,
      required this.userCart});

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      "userUID": userUID,
      "userEmail": userEmail,
      "userName": userName,
      "userPhotoUrl": userPhotoUrl,
      // "userCart" : ['garbageValue'],
      "userCart" : List<String>.from(userCart.map((x) => x)),
    };
    return map;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    userUID: map['userUID'],
    userEmail: map['userEmail'],
    userName: map['userName'],
    userPhotoUrl: map['userPhotoUrl'],
    userCart: List<String>.from(map["userCart"].map((x) => x)),
  );
}