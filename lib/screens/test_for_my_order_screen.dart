// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:foodfair/models/order_model.dart';
// import 'package:foodfair/providers/order_provider.dart';
// import 'package:foodfair/widgets/progress_bar.dart';
// import 'package:foodfair/global/add_item_to_cart.dart';
// import 'package:foodfair/global/global_instance_or_variable.dart';
// import 'package:foodfair/widgets/my_order_wiget.dart';
// import 'package:foodfair/widgets/simple_appbar.dart';
// import 'package:provider/provider.dart';
//
// class MyOrderSceen extends StatefulWidget {
//   const MyOrderSceen({Key? key}) : super(key: key);
//
//   @override
//   State<MyOrderSceen> createState() => _MyOrderSceenState();
// }
//
// class _MyOrderSceenState extends State<MyOrderSceen> {
//   late OrderProvider _orderProvider;
//   bool _init = true;
//
//   @override
//   void didChangeDependencies() {
//     if(_init){
//       _orderProvider = Provider.of<OrderProvider>(context, listen: false);
//       _orderProvider.fetchOrders().then((value) {
//         setState((){
//           _init = false;
//         });
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: SimpleAppbar(title: "My orders"),
//         body: StreamBuilder<QuerySnapshot>(
//           //here we get the order list of order collection which are normal
//           stream: _orderProvider.ordersData,
//           builder: (c, snapshot) {
//             return snapshot.hasData
//                 ? ListView.builder(
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (context, index) {
//                   return FutureBuilder<QuerySnapshot>(
//                     //here we get the productIDs list inside of order collection for a specific user.
//                     future: _orderProvider.fetchOrderedItems(orderModel),
//                     builder: (c, snap) {
//                      // OrderModel orderModel = OrderModel.fromMap(snapshot.data!.docs[index].data() as Map<String, dynamic>);
//                       return snap.hasData
//                           ? MyOrderWidget(
//                         //snap.data!.docs.length = how many items(productIDs) is oreder by a specific user
//                         //for a specific order not all orderlist
//                         itemCount: snap.data!.docs.length,
//                         //snap.data!.docs = all productID list
//                         data: snap.data!.docs,
//                         //passing order id one by one. we know inside of a specific order
//                         //id we will get many productIDs
//                         orderID: snapshot.data!.docs[index].id,
//                         separateItemsQuantityList:
//                         separateItemQuantityFromOrdersCollection(
//                             (snapshot.data!.docs[index].data()!
//                             as Map<String, dynamic>)[
//                             "productIDs"]),
//                       )
//                           : Center(
//                         child: circularProgress(),
//                       );
//                     },
//                   );
//                 })
//                 : Center(
//               child: circularProgress(),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
