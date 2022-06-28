import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper{
  //fetch all sellers
  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>>? fetchAllSellers()async{
     Stream<QuerySnapshot<Map<String, dynamic>>>? queryData;
    try{
       queryData = FirebaseFirestore.instance.collection("sellers").snapshots();
      return queryData;
    }catch(error){
      throw "error";
    }
  }
}