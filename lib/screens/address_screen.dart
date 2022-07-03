import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodfair/widgets/progress_bar.dart';
import 'package:foodfair/providers/address.dart';
import 'package:foodfair/widgets/address_widget.dart';
import 'package:foodfair/widgets/simple_appbar.dart';
import 'package:provider/provider.dart';
import '../global/global_instance_or_variable.dart';
import '../models/address_model.dart';
import '../providers/total_amount.dart';
import 'save_address_screen.dart';

class AddressScreen extends StatefulWidget {
  static final String path = "/AddressScreen";

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppbar(title: "foodfair",),
      floatingActionButton: SizedBox(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.50,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamed(SaveAddressScreen.path);
          },
          label: const Text("Add new address"),
          icon: const Icon(
            Icons.add_location,
            color: Colors.white,
          ),
          backgroundColor: Colors.cyan,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            //side: const BorderSide(color: Colors.red),
          ),
        ),
      ),
      body: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Select Address",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Consumer2<AddressProvider, TotalAmountProvider>(
              builder: (context, address, tAmount, ch) {
            return Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(sPref!.getString("uid"))
                    .collection("userAddress")
                    .snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Center(
                          child: circularProgress(),
                        )
                      : snapshot.data!.docs.length == 0
                          ? Text("")
                          : ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                AddressModel? addressModel = AddressModel.fromJson(
                                  snapshot.data!.docs[index].data()!
                                      as Map<String, dynamic>,
                                );
                                return AddressWidget(
                                  currentAddressIndex: address.count,
                                  value: index,
                                  addressID: snapshot.data!.docs[index].id,
                                  totalAmount: tAmount.totalAmount,
                                  addressModel: addressModel,
                                );
                              });
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
