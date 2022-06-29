import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodfair/db/db_helper.dart';

class SellersProvider with ChangeNotifier{
  Stream<QuerySnapshot<Map<String, dynamic>>>? _allSellerData;
  Stream<QuerySnapshot<Map<String, dynamic>>>? _specificSellerMenus;
  Stream<QuerySnapshot<Map<String, dynamic>>>? _specificSellerItems;
  Stream<QuerySnapshot<Map<String, dynamic>>>? get allSellersData => _allSellerData;
  Stream<QuerySnapshot<Map<String, dynamic>>>? get specificSellerMenus => _specificSellerMenus;
  Stream<QuerySnapshot<Map<String, dynamic>>>? get specificSellerItems => _specificSellerItems;

  //fetch all sellers
  Future<void> fetchAllSellers()async{
    _allSellerData = await DbHelper.fetchAllSellers();
    notifyListeners();
  }

  //fetch specific seller menus with id
  Future<void> fetchSpecificSellerMenus(String sellerID)async{
    _specificSellerMenus = await DbHelper.fetchSpecificSellerMenus(sellerID);
    notifyListeners();
  }

  //fetch specific seller items with his or her id
  Future<void> fetchSpecificSellerItems(String sellerID, String menuID)async{
    _specificSellerItems = await DbHelper.fetchSpecificSellerItems(sellerID, menuID);
    notifyListeners();
  }
}