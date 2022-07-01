import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodfair/db/db_helper.dart';
import 'package:foodfair/models/order_model.dart';

class OrderProvider with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>>? _ordersData;
  Stream<QuerySnapshot<Map<String, dynamic>>>? get ordersData => _ordersData;

  //add order
  Future<void> addOrder(OrderModel orderModel, String orderId) async {
    return DbHelper.addOrder(orderModel, orderId);
  }

  //fetch orders for specific user
  Future<void> fetchOrders() async {
    _ordersData = await  DbHelper.fetchOrders();
    notifyListeners();
  }

  //fetch items those are ordered from a specific user
  Future<QuerySnapshot<Map<String, dynamic>>> fetchOrderedItems(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index)async{
    return  DbHelper.fetchOrderedItems(snapshot, index);
  }
}
