import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodfair/models/order_model.dart';
import 'package:foodfair/models/user_model.dart';

import '../global/add_item_to_cart.dart';
import '../global/global_instance_or_variable.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  //fetch all sellers
  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>>?
  fetchAllSellers() async {
    Stream<QuerySnapshot<Map<String, dynamic>>>? queryData;
    try {
      queryData = _db
          .collection(
        "sellers",
      )
          .snapshots();
      return queryData;
    } catch (error) {
      throw "error";
    }
  }

  //fetch a specific seller menu with once's id
  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>>
  fetchSpecificSellerMenus(String sellerID) async {
    Stream<QuerySnapshot<Map<String, dynamic>>>? queryData;
    try {
      queryData = _db
          .collection("sellers")
          .doc(sellerID)
          .collection("menus")
          .orderBy("publishedDate", descending: true)
          .snapshots();
      return queryData;
    } catch (error) {
      throw "error";
    }
  }

  // fetch a specific seller items with id
  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>>
  fetchSpecificSellerItems(String sellerID, String menuID) async {
    Stream<QuerySnapshot<Map<String, dynamic>>>? queryData;
    try {
      queryData = _db
          .collection("sellers")
          .doc(sellerID)
          .collection("menus")
          .doc(menuID)
          .collection("items")
          .orderBy("publishedDate", descending: true)
          .snapshots();
      return queryData;
    } catch (error) {
      throw "error";
    }
  }

  //add user in firestore
  static Future<void> addUser(UserModel userModel, String userId) async {
    return _db.collection("users").doc(userId).set(userModel.toMap());
  }

  //add order
  static Future<void> addOrder(OrderModel orderModel, String orderId) async {
    await _db
        .collection("users")
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

  //fetch specific user's orders
  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>>?
  fetchOrders() async {
    Stream<QuerySnapshot<Map<String, dynamic>>>? queryData;
    try {
      //here we get the order list of order collection which are normal
      queryData = _db
          .collection("users")
          .doc(sPref!.getString("uid"))
          .collection("orders")
          .where("status", isEqualTo: "normal")
          .orderBy("orderTime", descending: true)
          .snapshots();
      return queryData;
    } catch (error) {
      throw "error";
    }
  }

  //fetch items those are ordered from a specific user
  static Future<QuerySnapshot<Map<String, dynamic>>> fetchOrderedItems(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) async {
    QuerySnapshot<Map<String, dynamic>> queryData;
    try {
      queryData = await _db
          .collection(
          "items") /*insdie of items colleciton we will search which items are ordered.*/
          .where("itemID",
          /*if itemID is exist in separateOrdersItemsIDs*/
          whereIn: separatedItemIDFromOrdersCollection(
            /*snapshot.data.docs[index].data() == it gives only one order id.
                                     And inside of a specific order id we get productID list(name as productIDs)
                                     productIDs = here we have itemID and item quantiy.so separateItemIDFromOrdersCollection()
                                      by this fuction we will extract just itemID
                                     */
              (snapshot.data!.docs[index].data()!
              as Map<String, dynamic>)["productIDs"]))
      // this is unnecessary just order by..
          .where("orderBy",
          /*orderBy = a specific user*/ whereIn: (snapshot.data!.docs[index]
              .data()! as Map<String, dynamic>)["uid"])
          .orderBy("publishedDate", descending: true)
          . /*instead of snapshot() we use here get(), the reason
                             for using FutureBuilder*/
      get();
      return queryData;
    } catch (error) {
      throw "error";
    }
  }
}
