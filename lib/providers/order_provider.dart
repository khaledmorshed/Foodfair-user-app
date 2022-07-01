import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodfair/db/db_helper.dart';
import 'package:foodfair/models/order_model.dart';

class OrderProvider with ChangeNotifier {
  Future<void> addOrder(OrderModel orderModel, String orderId) async {
    return DbHelper.addOrder(orderModel, orderId);
  }
}
