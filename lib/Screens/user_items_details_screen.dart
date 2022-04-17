import 'package:flutter/material.dart';

import 'package:foodfair/models/items.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

import '../global/add_item_to_cart.dart';

class UserItemsDetailsScreen extends StatefulWidget {
  final Items? itemModel;
  const UserItemsDetailsScreen({
    Key? key,
    this.itemModel,
  }) : super(key: key);
  @override
  State<UserItemsDetailsScreen> createState() => _UserItemsDetailsScreenState();
}

class _UserItemsDetailsScreenState extends State<UserItemsDetailsScreen> {
  TextEditingController counterTextEditingController = TextEditingController();
  int itemCounter = 1;
  @override
  Widget build(BuildContext context) {
    print("mutton burger itemId = ${widget.itemModel!.itemID} + (1650134716838673) VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV ()");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemModel!.itemTitle.toString()),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  // add to cart
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              const Positioned(
                top: 3,
                right: 10,
                child: Center(
                    child: Text(
                  "0",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                )),
              )
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          Image.network(widget.itemModel!.itemImageUrl.toString()),
          // NumberInputPrefabbed.roundedButtons(
          //   controller: counterTextEditingController,
          //   buttonArrangement: ButtonArrangement.incRightDecLeft,
          //   incIcon: Icons.add,
          //   scaleWidth: 0.75,
          // ),

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
              onPressed: () {
                addItemToCart(widget.itemModel!.itemID, context, itemCounter);
              },
            )
          ],
        ),
      ),
    );
  }
}
