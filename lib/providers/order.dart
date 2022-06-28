import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodfair/providers/seller.dart';
import 'package:foodfair/providers/total_amount.dart';
import 'package:provider/provider.dart';
import '../screens/user_home_screen.dart';
import '../global/add_item_to_cart.dart';
import '../global/global_instance_or_variable.dart';

String? orderId;
 DateTime? timestamp;
class OrderProvider with ChangeNotifier {
  addOrderDetails(String? addressID, BuildContext context,/* String? sellerUid,*/ double? tAmount) async {
     timestamp = DateTime.now();
    orderId = DateTime.now().millisecondsSinceEpoch.toString();
    // double? tAmount =
    //     Provider.of<TotalAmountProvider>(context, listen: false).totalAmount;
    // String? sellerUid =
    //     Provider.of<SellerProvider>(context, listen: false).sellerUID;
    writeOrderDetailsForUser({
      "addressID": addressID,
      "totalAmount": tAmount,
      "orderBy": sPref!.getString("uid"),
      "productIDs": sPref!.getStringList("userCart"),
      "paymentDetails": "Cash on Delivery",
      "orderTime": timestamp!.toIso8601String(),
      "isSuccess": true,
      "sellerUID": sellerUIDD,
      "riderUID": "",
      "status": "normal",
      "orderId": orderId,
    });

    writeOrderDetailsForSeller({
      "addressID": addressID,
      "totalAmount": tAmount,
      "orderBy": sPref!.getString("uid"),
      "productIDs": sPref!.getStringList("userCart"),
      "paymentDetails": "Cash on Delivery",
      "orderTime": timestamp!.toIso8601String(),
      "isSuccess": true,
      "sellerUID": sellerUIDD,
      "riderUID": "",
      "status": "normal",
      "orderId": orderId,
    }).whenComplete(() {
      clearCart(context);
      // setState(() {
      orderId = "";
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const UserHomeScreen()));
      Fluttertoast.showToast(
          msg: "Congratulations, Order has been placed successfully.");
      // });
    });
  }

  Future writeOrderDetailsForUser(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sPref!.getString("uid"))
        .collection("orders")
        .doc(orderId)
        .set(data);
  }

  Future writeOrderDetailsForSeller(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .set(data);
  }

}
