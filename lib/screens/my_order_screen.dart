import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foodfair/models/order_model.dart';
import 'package:foodfair/providers/order_provider.dart';
import 'package:foodfair/widgets/progress_bar.dart';
import 'package:foodfair/global/add_item_to_cart.dart';
import 'package:foodfair/global/global_instance_or_variable.dart';
import 'package:foodfair/widgets/my_order_wiget.dart';
import 'package:foodfair/widgets/simple_appbar.dart';
import 'package:provider/provider.dart';

class MyOrderSceen extends StatefulWidget {
  const MyOrderSceen({Key? key}) : super(key: key);

  @override
  State<MyOrderSceen> createState() => _MyOrderSceenState();
}

class _MyOrderSceenState extends State<MyOrderSceen> {
  late OrderProvider _orderProvider;
  bool _init = true;

  @override
  void didChangeDependencies() async{

    if(_init){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _orderProvider = Provider.of<OrderProvider>(context, listen: false);
        _orderProvider.fetchOrders().then((value) {
          setState((){
            print("10 + ordermodel = + + BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBbbbb");
            _init = false;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   // print("9 + ordermodel = + + BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBbbbb");
    return SafeArea(
      child: Scaffold(
        appBar: SimpleAppbar(title: "My orders"),
        body: _init ? Center(child: CircularProgressIndicator(),) : StreamBuilder<QuerySnapshot>(
          //here we get the order list of order collection which are normal
          stream: _orderProvider.ordersData,
          builder: (c, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  print("$index + orderId in myorderScreen = + ${snapshot.data!.docs[index].id}+ BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBbbbb");
                  OrderModel orderModel = OrderModel.fromMap(snapshot.data!.docs[index].data() as Map<String, dynamic>);
                  return MyOrderWidget(
                    orderModel: orderModel
                  );
                })
                : Center(
              child: circularProgress(),
            );
          },
        ),
      ),
    );
  }
}
