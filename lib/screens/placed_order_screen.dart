import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodfair/providers/order.dart';
import 'package:foodfair/widgets/container_decoration.dart';

import '../global/color_manager.dart';


class PlacedOrderScreen extends StatefulWidget {
  //static final String path = "/PlacedOrderScreen";
  String? addressID;
  String? sellerID;
  double? tAmount;

  PlacedOrderScreen({
    Key? key,
    this.addressID,
    this.sellerID,
    this.tAmount,
  }) : super(key: key);

  @override
  State<PlacedOrderScreen> createState() => _PlacedOrderScreenState();
}

class _PlacedOrderScreenState extends State<PlacedOrderScreen> {
  //String orderId = DateTime.now().millisecondsSinceEpoch.toString();
  //String? sellerUid;
  //var  addressId = '';
  //double? tAmount;
  //String? addressId;
  /* addOrderDetails() {
    writeOrderDetailsForUser({
      "addressID": addressID,
      "totalAmount": tAmount,
      "orderBy": sPref!.getString("uid"),
      "productIDs": sPref!.getStringList("userCart"),
      "paymentDetails": "Cash on Delivery",
      "orderTime": orderId,
      "isSuccess": true,
      "sellerUID": sellerUid,
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
      "orderTime": orderId,
      "isSuccess": true,
      "sellerUID": sellerUid,
      "riderUID": "",
      "status": "normal",
      "orderId": orderId,
    }).whenComplete(() {
      clearCart(context);
      setState(() {
        orderId = "";
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UserHomeScreen()));
        Fluttertoast.showToast(
            msg: "Congratulations, Order has been placed successfully.");
      });
    });
  }

   Future writeOrderDetailsForUser(Map<String, dynamic> data) async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sPref!.getString("uid"))
        .collection("orders")
        .doc(orderId)
        .set(data);
  }

  Future writeOrderDetailsForSeller(Map<String, dynamic> data) async
  {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .set(data);
  }*/

  // @override
  // void initState() {
  //   // sellerUid = Provider.of<SellerProvider>(context, listen: false).sellerUID;
  //   // tAmount =
  //   //     Provider.of<TotalAmountProvider>(context, listen: false).totalAmount;
  //   addressId = widget.addressID;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    //addressID = ModalRoute.of(context)!.settings.arguments as String;
    // sellerUid = Provider.of<SellerProvider>(context, listen: false).sellerUID;
    // tAmount =
    //     Provider.of<TotalAmountProvider>(context, listen: false).totalAmount;
    return Scaffold(
      body: Container(
        decoration: ContainerDecoration().decoaration(),
        child: Column(
          children: [
            Image.asset("assets/images/delivery.jpg"),
            ElevatedButton(
              child: const Text(
                "Confirm",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple[300],
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: ColorManager.depOrange1),
                ),
              ),
              onPressed: () async {
                // Consumer<OrderProvider>(
                //   builder: (context, addorder, ch) {
                //     return addorder.addOrderDetails(addressID, context);
                //   },
                // );
                // String sellerUid = Provider.of<SellerProvider>(context, listen: false)
                //     .sellerUID;
                // tAmount =
                //     Provider.of<TotalAmountProvider>(context, listen: false)
                //         .totalAmount;
                await Provider.of<OrderProvider>(context, listen: false)
                    .addOrderDetails(widget.addressID, context, widget.tAmount);
              },
            ),
          ],
        ),
      ),
    );
  }
}
