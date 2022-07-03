import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodfair/db/db_helper.dart';
import 'package:foodfair/models/items_model.dart';
import 'package:foodfair/models/order_model.dart';

class OrderProvider with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>>? _ordersData;
  Stream<QuerySnapshot<Map<String, dynamic>>>? get ordersData => _ordersData;
  List<ItemModel> _itemModelList =  [];
  List<ItemModel> get itemModelList => _itemModelList;

  //add order
  Future<void> addOrder(OrderModel orderModel, String orderId) async {
    return DbHelper.addOrder(orderModel, orderId);
  }

  //fetch orders for specific user
  Future<void> fetchOrders() async {
    _ordersData = await DbHelper.fetchOrders();
    notifyListeners();
  }

  //fetch items those are ordered from a specific user
  Future<void> fetchOrderedItems(
      OrderModel orderModel)async {
      await DbHelper.fetchOrderedItems(orderModel).then((snapshot)async{
       _itemModelList = [];
        _itemModelList = List.generate(snapshot.docs.length, (index) => ItemModel.fromJson(snapshot.docs[index].data()));
       notifyListeners();
       print("rderid ${orderModel.orderId}");

       for(int i=0; i<_itemModelList.length; i++){
         print(" itemId + ${_itemModelList[i].itemID} +");
       }

     });
  }
}
