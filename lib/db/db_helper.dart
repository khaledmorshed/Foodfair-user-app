import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper{
  //fetch all sellers
  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>>? fetchAllSellers()async{
     Stream<QuerySnapshot<Map<String, dynamic>>>? queryData;
    try{
       queryData = FirebaseFirestore.instance.collection("sellers", ).snapshots();
      return queryData;
    }catch(error){
      throw "error";
    }
  }

  //fetch a specific seller menu with once's id
  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>> fetchSpecificSellerMenus(String sellerID)async{
    Stream<QuerySnapshot<Map<String, dynamic>>>? queryData;
    try{
      queryData = FirebaseFirestore.instance
          .collection("sellers")
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
      queryData = FirebaseFirestore.instance
          .collection("sellers")
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
}