import 'package:flutter/material.dart';
import 'package:foodfair/db/db_helper.dart';
import 'package:foodfair/models/user_model.dart';

class UserProvider with ChangeNotifier{

    Future<void> addUser(UserModel user, String userId)async{
       return DbHelper.addUser(user, userId);
    }
}