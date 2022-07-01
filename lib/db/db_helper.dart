import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodfair/models/order_model.dart';
import 'package:foodfair/models/user_model.dart';

import '../global/global_instance_or_variable.dart';

class DbHelper{
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  //fetch all sellers
  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>>? fetchAllSellers()async{
     Stream<QuerySnapshot<Map<String, dynamic>>>? queryData;
    try{
       queryData = _db.collection("sellers", ).snapshots();
      return queryData;
    }catch(error){
      throw "error";
    }
  }

  //fetch a specific seller menu with once's id
  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>> fetchSpecificSellerMenus(String sellerID)async{
    Stream<QuerySnapshot<Map<String, dynamic>>>? queryData;
    try{
      queryData = _db.collection("sellers")
          .doc(sellerID)
          .collection("menus")
          .orderBy("publishedDate", descending: true)
          .snapshots();
      return queryData;
    }catch(error){
      throw "error";
    }
  }

  // fetch a specific seller items with id
  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>> fetchSpecificSellerItems(String sellerID, String menuID)async{
    Stream<QuerySnapshot<Map<String, dynamic>>>? queryData;
    try{
      queryData = _db.collection("sellers")
          .doc(sellerID)
          .collection("menus")
          .doc(menuID)
          .collection("items")
          .orderBy("publishedDate", descending: true)
          .snapshots();
      return queryData;
    }catch(error){
      throw "error";
    }
  }

  //add user in firestore
  static Future<void> addUser(UserModel userModel, String userId)async{
    return _db.collection("users").doc(userId).set(userModel.toMap());
  }

  //add order
  static Future<void> addOrder(OrderModel orderModel, String orderId)async{
    for(int i = 0; i<orderModel.productIDs.length; i++){
      print("1 + productList = ${orderModel.productIDs[i]} + AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    }
    await _db.collection("users")
        .doc(sPref!.getString("uid"))
        .collection("orders")
        .doc(orderId)
        .set(orderModel.toMap());

    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .set(orderModel.toMap());
    return;
  }
}