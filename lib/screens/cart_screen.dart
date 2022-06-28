import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodfair/widgets/progress_bar.dart';
import 'package:foodfair/models/items.dart';
import 'package:foodfair/providers/total_amount.dart';
import 'package:foodfair/widgets/cart_widget.dart';
import 'package:foodfair/widgets/my_appbar.dart';
import 'package:foodfair/widgets/text_widget_header.dart';
import 'package:provider/provider.dart';

import '../global/add_item_to_cart.dart';
import '../global/color_manager.dart';
import '../providers/cart_item_quantity.dart';
import '../widgets/container_decoration.dart';
import 'address_screen.dart';

class CartScreen extends StatefulWidget {
  /*final String? sellerUID;
  const CartScreen({
    Key? key,
    this.sellerUID,
  }) : super(key: key);*/

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int>? separatedItemQuantityList;
  double _totalAmount = 0;

  @override
  void initState() {
    //this list of quantiy of integer type
    // Provider.of<TotalAmountProvider>(context, listen: false)
    //     .displayTotalAmount(_totalAmount);
    separatedItemQuantityList = separateItemsQuantityFromUserCartList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("foods"),
        centerTitle: true,
        //automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const ContainerDecoration().decoaration(),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart),
              ),
              Positioned(
                top: 3,
                right: 10,
                child: Consumer<CartItemQuanityProvider>(
                  builder: (context, itemCounter, ch) {
                    return Text(
                      itemCounter.itemQuantity.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn1",
              onPressed: () {
                clearCart(context);
                Provider.of<TotalAmountProvider>(context, listen: false)
                    .displayTotalAmount(0);
              },
              label: const Text(
                "Clear cart",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              backgroundColor: ColorManager.purple2,
              icon: const Icon(Icons.clear_all),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn2",
              onPressed: () {
                Navigator.of(context).pushNamed(AddressScreen.path);
              },
              label: const Text(
                "Check Out",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              backgroundColor: ColorManager.purple2,
              icon: const Icon(Icons.navigate_next),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          Consumer2<TotalAmountProvider, CartItemQuanityProvider>(
            builder: ((context, amountProvider, quantityProivder, child) {
              return SliverPersistentHeader(
                pinned: true,
                delegate: quantityProivder.itemQuantity == 0
                    ? TextWidgetHeader(title: "Total price = Tk 0")
                    : TextWidgetHeader(
                        title:
                            "Total price = Tk ${amountProvider.totalAmount}"),
              );
            }),
          ),

          // SliverPersistentHeader(
          //   pinned: true,
          //   delegate: TextWidgetHeader(title: "Total = Tk 2000"),
          // ),
          // SliverPersistentHeader(
          //   pinned: true,
          //   delegate: Consumer2<TotalAmountProvider, CartItemQuanity>(builder: ((context, value, value2, child){
          //     return TextWidgetHeader(title: "Total = Tk 2000"),
          //   }),)

          // ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("items")
                .where("itemID", whereIn: separateItemsIdFromUserCartList())
                .orderBy("publishedDate", descending: false)
                .snapshots(),
            builder: (context, /* AsyncSnapshot<QuerySnapshot?> */ snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(child: circularProgress()),
                    )
                  : /*snapshot.data!.docs.length == 0
                      ? /*startBuildingcart*/ Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.red,
                        )
                      : */
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          Items itemModel = Items.fromJson(
                            snapshot.data!.docs[index].data()
                                as Map<String, dynamic>,
                          );
                          print(
                              " 1 total = ${_totalAmount} + AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                          if (index == 0) {
                            _totalAmount = 0;
                            _totalAmount = _totalAmount +
                                (itemModel.price! *
                                    separatedItemQuantityList![index]);
                            print(
                                " 100 index  = $index + value = ${separatedItemQuantityList![index]} + IIIIIIIIIIIIIIIIIIIIIIIIIII");
                          } else {
                            _totalAmount = _totalAmount +
                                (itemModel.price! *
                                    separatedItemQuantityList![index]);
                            print(
                                " 101 index = $index + value = ${separatedItemQuantityList![index]} + IIIIIIIIIIIIIIIIIIIIIIIIIII");
                          }
                          if (snapshot.data!.docs.length - 1 == index) {
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              Provider.of<TotalAmountProvider>(context,
                                      listen: false)
                                  .displayTotalAmount(_totalAmount);
                            });

                            // Provider.of<TotalAmountProvider>(context,
                            //         listen: false)
                            //     .displayTotalAmount(_totalAmount);
                          }
                          print(
                              " 2 total = ${_totalAmount} + AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaa");
                          return CartWidget(
                            itemModel: itemModel,
                            context: context,
                            quantityNumber: separatedItemQuantityList![index],
                            total: _totalAmount,
                          );
                        },
                        childCount:
                            snapshot.hasData ? snapshot.data!.docs.length : 0,
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
