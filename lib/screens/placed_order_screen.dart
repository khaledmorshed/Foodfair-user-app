import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodfair/global/add_item_to_cart.dart';
import 'package:foodfair/models/order_model.dart';
import 'package:foodfair/screens/user_home_screen.dart';
import 'package:provider/provider.dart';
import 'package:foodfair/providers/order_provider.dart';
import 'package:foodfair/widgets/container_decoration.dart';
import '../global/color_manager.dart';
import '../global/global_instance_or_variable.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
            decoration: ContainerDecoration().decoaration(),
            child: Column(
              children: [
                Image.asset("assets/images/delivery.png"),
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
                    previousSellerId = '';

                    DateTime timestamp =  DateTime.now();;
                    String orderId = timestamp.millisecondsSinceEpoch.toString();
                    final _orderModel = OrderModel(
                      addressID: widget.addressID,
                      totalAmount: widget.tAmount,
                      orderBy: sPref!.getString("uid"),
                      productIDs: sPref!.getStringList("userCart")!,
                      paymentDetails:"Cash on Delivery",
                      orderTime: timestamp.toIso8601String(),
                      isSuccess: true,
                      sellerUID: sellerUIDD,
                      riderUID: "",
                      status: "normal",
                      orderId: orderId,
                    );

                    for(int i = 0; i<_orderModel.productIDs.length; i++){
                      print("0 + productList = ${_orderModel.productIDs[i]} + AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                    }

                    await Provider.of<OrderProvider>(context, listen: false)
                        .addOrder(_orderModel, orderId).then((value){
                          clearCart(context);
                          orderId = '';
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const UserHomeScreen()));
                          Fluttertoast.showToast(
                              msg: "Congratulations, Order has been placed successfully.");
                    });
                  },
                ),
              ],
            ),
          ),
        ),
    );
  }
}
