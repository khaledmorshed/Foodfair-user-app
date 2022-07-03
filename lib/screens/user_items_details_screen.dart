import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

import 'package:foodfair/models/items_model.dart';
import 'package:foodfair/widgets/my_appbar.dart';

import '../global/add_item_to_cart.dart';
import '../global/global_instance_or_variable.dart';
import '../widgets/loading_container.dart';

class UserItemsDetailsScreen extends StatefulWidget {
  final ItemModel? itemModel;
  String? sellerUID;
  UserItemsDetailsScreen({
    Key? key,
    this.itemModel,
    this.sellerUID,
  }) : super(key: key);
  @override
  State<UserItemsDetailsScreen> createState() => _UserItemsDetailsScreenState();
}

class _UserItemsDetailsScreenState extends State<UserItemsDetailsScreen> {
  TextEditingController counterTextEditingController = TextEditingController();
  int itemCounter = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(/*sellerUID: widget.itemModel!.sellerUID*/),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: widget.itemModel!.itemImageUrl.toString(),
            placeholder: (context, url) => Center(child: LoadingContainer()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Container(
            margin: EdgeInsets.all(15),
            alignment: Alignment.bottomRight,
            //color: Colors.red,
            child: Text(
              "Tk " + widget.itemModel!.price.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              widget.itemModel!.shortInformation.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 15, right: 15),
            child: Text(
              widget.itemModel!.itemDescription.toString(),
              style: const TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (itemCounter == 0) {
                    } else
                      itemCounter = itemCounter - 1;
                  });
                },
                icon: const Icon(Icons.remove)),
            Text("${itemCounter}"),
            IconButton(
                onPressed: () {
                  setState(() {
                    itemCounter = itemCounter + 1;
                  });
                },
                icon: Icon(Icons.add)),
            TextButton(
              child: const Text('Add to cart'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.teal,
                primary: Colors.white,
                //Primary: Colors.white,
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3))),
              ),
              onPressed: () async{
                String currentSellerId = widget.itemModel!.sellerUID!;
                //String currentSellerId = previousSellerId;
                if(previousSellerId == '' || previousSellerId == currentSellerId){
                  previousSellerId = widget.itemModel!.sellerUID!;
                  List<String> separatedItemsIDList =
                  separateItemsIdFromUserCartList();
                  separatedItemsIDList.contains(widget.itemModel!.itemID) ?
                  Fluttertoast.showToast(msg: "Item is already in cart") :
                  addItemToCart(widget.itemModel!.itemID, context, itemCounter, widget.itemModel!.sellerUID.toString());
                }
                else{
                  //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("order at first")));
                  return await showDialog(context: (context), builder: (context) => AlertDialog(
                    title: Text('Remove your previous items?'),
                    content: Text("You have added products in cart from another restaurant. Do you want to remove those?"),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        TextButton(onPressed: (){

                          Navigator.pop(context);
                        }, child: Text("yes")),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("no"))
                      ],
                      ),
                    ],
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
