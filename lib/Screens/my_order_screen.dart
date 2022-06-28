// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:foodfair/exceptions/progress_bar.dart';
// import 'package:foodfair/global/add_item_to_cart.dart';
// import 'package:foodfair/global/global_instance_or_variable.dart';
// import 'package:foodfair/widgets/simple_appbar.dart';
//
// class MyOrderSceen extends StatefulWidget {
//   const MyOrderSceen({Key? key}) : super(key: key);
//
//   @override
//   State<MyOrderSceen> createState() => _MyOrderSceenState();
// }
//
// class _MyOrderSceenState extends State<MyOrderSceen> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: SimpleAppbar(title: "My orders"),
//         body: StreamBuilder<QuerySnapshot>(
//           //here we get the order list of order collection which are normal
//           stream: FirebaseFirestore.instance
//               .collection("users")
//               .doc(sPref!.getString("uid"))
//               .collection("orders")
//               .where("status", isEqualTo: "normal")
//               .orderBy("orderTime", descending: true)
//               .snapshots(),
//           builder: (c, snapshot) {
//             return snapshot.hasData
//                 ? ListView.builder(
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       return FutureBuilder<QuerySnapshot>(
//                         /*
//                         FirebaseFirestore.instance
//                               .collection("items")
//                               .where("itemID", whereIn: separateOrderItemIDs((snapshot.data!.docs[index].data()!
//                                as Map<String, dynamic>) ["productIDs"]))
//                               .where("orderBy", whereIn: (snapshot.data!.docs[index].data()! as Map<String, dynamic>)["uid"])
//                               .orderBy("publishedDate", descending: true)
//                               .get(),
//                         */
//                         //here we get the productIDs list inside of order collection for a specific user.
//                         future: FirebaseFirestore.instance
//                             .collection(
//                                 "items") /*insdie of items colleciton we will search which items are ordered.*/
//                             .where("itemID",
//                                 /*if itemID is exist in separateOrdersItemsIDs*/
//                                 whereIn: separateItemIDFromOrdersCollection(
//                                     /*snapshot.data.docs[index] == it gives only one order id.
//                                      And inside of a specific order id we get productID list(name as productIDs)
//                                      productIDs = here we have itemID and item quantiy.so separateItemIDFromOrdersCollection()
//                                       by this fuction we will extract just itemID
//                                      */
//                                     (snapshot.data!.docs[index].data()!
//                                         as Map<String, dynamic>)["productIDs"]))
//                             .where("orderBy",
//                                 /*orderBy = a specific user*/ whereIn:
//                                     (snapshot.data!.docs[index].data()!
//                                         as Map<String, dynamic>)["uid"])
//                             .orderBy("publishedDate", descending: true)
//                             . /*instead of snapshot() we use here get(), the reason
//                              for using FutureBuilder*/
//                             get(),
//                         builder: (c, snap) {
//                           return snap.hasData
//                               ? MyOrderWidget(
//                                   //snap.data!.docs.length = how many items(productIDs) is oreder by a specific user
//                                   itemCount: snap.data!.docs.length,
//                                   //snap.data!.docs = all productID list
//                                   data: snap.data!.docs,
//                                   //passing order id one by one. we know inside of a specific order
//                                   //id we will get many productIDs
//                                   orderID: snapshot.data!.docs[index].id,
//                                   separateItemsQuantityList:
//                                       separateItemQuantityFromOrdersCollection(
//                                           (snapshot.data!.docs[index].data()!
//                                                   as Map<String, dynamic>)[
//                                               "productIDs"]),
//                                 )
//                               : Center(
//                                   child: circularProgress(),
//                                 );
//                         },
//                       );
//                     })
//                 : Center(
//                     child: circularProgress(),
//                   );
//           },
//         ),
//       ),
//     );
//   }
// }
