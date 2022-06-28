import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodfair/Screens/user_home_screen.dart';
import 'package:foodfair/global/global_instance_or_variable.dart';
import 'package:provider/provider.dart';
import '../providers/cart_item_quantity.dart';

separateItemsIdFromUserCartList() {
  List<String> separateItemsIdsList = [], getPreviouslySavedItemsList = [];
  getPreviouslySavedItemsList = sPref!.getStringList("userCart")!;

  for (int i = 0; i < getPreviouslySavedItemsList.length; i++) {
    //here inside of item itemsID and qunatity of item are assigned like("1650134716838673:2")
    String item = getPreviouslySavedItemsList[i].toString();
    //we extract itemsID(1650134716838673) from "1650134716838673:2" here by item.lastIndexOf(":")
    var pos = item.lastIndexOf(":");
    String getItemID = (pos != -1) ? item.substring(0, pos) : item;
    separateItemsIdsList.add(getItemID);
  }
  return separateItemsIdsList;
}

addItemToCart(String? foodItemId, BuildContext context, int itemCounter) {
  List<String>? tempCartList = sPref!.getStringList("userCart");
  tempCartList!.add(foodItemId! + ":$itemCounter");
  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update({
    "userCart": tempCartList,
  }).then((value) {
    Fluttertoast.showToast(msg: "Item Added Successfully");
    sPref!.setStringList("userCart", tempCartList);
    //updating the shopping cart number
    //Provider.of(context)<CartItemQuanity>(context, listen: false).displayCartListItemsNumbers();

    Provider.of<CartItemQuanityProvider>(context, listen: false)
        .displayCartItemNumber();
  });
}

separateItemsQuantityFromUserCartList() {
  List<int> separateItemsQuantityList = [];
  List<String> getPreviouslySavedItemsList = sPref!.getStringList("userCart")!;

  //here indext start from 1 because inside of 0the indext we have garbase value
  for (int i = 1; i < getPreviouslySavedItemsList.length; i++) {
    //here inside of item itemsID and qunatity of item are assigned like("1650134716838673:2")
    String item = getPreviouslySavedItemsList[i].toString();

    //(1650134716838673:2)here simply mean that 0th index has : and 1th index has 2.
    List<String> listItemCharacters = item.split(":").toList();
    //here we get the 2 inside of quantityNumber
    var quantityNumber = int.parse(listItemCharacters[1].toString());
    separateItemsQuantityList.add(quantityNumber);
  }
  return separateItemsQuantityList;
}

clearCart(context) {
  //so now cart has only one value in 0the index which value is garbageValue
  sPref!.setStringList("userCart", ['garbageValue']);
  //now get that only one value inside of emptyList
  List<String>? emptyList = sPref!.getStringList("userCart");
  //now this emptyList set into firebaseFirestore
  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update({"userCart": emptyList}).then((value) {
    //now set it locally empyt aslo
    sPref!.setStringList("userCart", emptyList!);
    //now shopping cart need to set 0
    Provider.of<CartItemQuanityProvider>(context, listen: false)
        .displayCartItemNumber();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserHomeScreen()));
  });
}
