import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foodfair/models/items_model.dart';
import 'package:foodfair/models/order_model.dart';
import 'package:foodfair/widgets/fake_widget.dart';
import 'package:provider/provider.dart';
import '../global/add_item_to_cart.dart';
import '../providers/order_provider.dart';
import '../screens/order_detail_screen.dart';

class MyOrderWidget extends StatefulWidget {
  OrderModel? orderModel;

   MyOrderWidget({
    Key? key,
    this.orderModel,
  }) : super(key: key);

  @override
  State<MyOrderWidget> createState() => _MyOrderWidgetState();
}

class _MyOrderWidgetState extends State<MyOrderWidget> {
  int i = 0;
  late OrderProvider _orderProvider;
  bool _init = true;
  List<String> separateItemsQuantityList = [];
  @override
  void didChangeDependencies(){
   // print("${i++} + orderid in myorderwidget = + ${widget.orderModel!.orderId}+ CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC");
      print('');
      if(_init){
        _orderProvider = Provider.of<OrderProvider>(context, listen: false);
        _orderProvider.fetchOrderedItems(widget.orderModel!).then((value) {
          setState((){
            _init = false;
          });
          for(int i=0; i<_orderProvider.itemModelList.length; i++){
            //print(" 4 len = +${_orderProvider.itemModelList.length} = + itemId in myorderwidget = + ${_orderProvider.itemModelList[i].itemID}+ ");
          }
          print('');
        });
      }


  }

  @override
  Widget build(BuildContext context){
    return _init == true ? Center(child: CircularProgressIndicator(),) : InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailScreen(orderID: widget.orderModel!.orderId)));
      },
      child: Container(
        //color: Colors.white10,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.black12, width: 4),
            borderRadius: BorderRadius.circular(5)),
        height: (widget.orderModel!.productIDs.length - 1)  * 125,
        child: ListView.builder(
            itemCount: _orderProvider.itemModelList.length,
            // itemCount: widget.itemCount,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              for(int i=0; i<_orderProvider.itemModelList.length; i++){
                print(" view itemId + ${_orderProvider.itemModelList[i].itemID}+ ");
              }
              print('');
              separateItemsQuantityList =
                  separateItemQuantityFromOrdersCollection(widget.orderModel!.productIDs);
              return PlacedOrderDesignWidtet(_orderProvider.itemModelList[index], context, separateItemsQuantityList[index]);
            }),
      ),
    );
  }

}

Widget PlacedOrderDesignWidtet(
    ItemModel itemModel, BuildContext context, separateItemsQuantityList) {
 // print("6 + separateItemsQuantityList = + ${separateItemsQuantityList} + XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxxxxxxxx");
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 120,
    child: Row(
      children: [
        CachedNetworkImage(
          imageUrl: itemModel.itemImageUrl!,
          width: 120,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      itemModel.itemTitle!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      "Tk ${itemModel.price}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "x $separateItemsQuantityList",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
