import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:foodfair/models/items.dart';
import 'package:foodfair/models/menus.dart';
import 'package:foodfair/widgets/items_widget.dart';

import '../widgets/error_dialog.dart';
import '../global/global_instance_or_variable.dart';
import '../widgets/container_decoration.dart';
import '../widgets/loading_container.dart';
import '../widgets/my_appbar.dart';
import '../widgets/my_drawer.dart';
import '../widgets/text_widget_header.dart';

class UserItemsScreen extends StatefulWidget {
  final Menus? model;
  String? sellerUID;
 UserItemsScreen({
    Key? key,
    this.model,
    this.sellerUID,
  }) : super(key: key);

  @override
  State<UserItemsScreen> createState() => _UserItemsScreenState();
}

class _UserItemsScreenState extends State<UserItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(/*sellerUID: widget.model!.sellerUID*/),
      // drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            // pinned: true,
            delegate:
                TextWidgetHeader(title: widget.model!.menuTitle! + "'s items"),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(widget.model!.sellerUID)
                .collection("menus")
                .doc(widget.model!.menuID)
                .collection("items")
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
              if (snapshot.hasError) {
                ErrorDialog(
                  message: "${snapshot.error}",
                );
                //return  Text('Error: ${snapshot.error}');
              }
              if (snapshot.hasError) {
                return Text("No net");
              }

              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: LoadingContainer(),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          Items itemModel = Items.fromJson(
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>);
                          return ItemsWidget(
                            itemModel: itemModel,
                            context: context,
                            sellerUID: widget.sellerUID
                            //netValue: model.isOnline,
                          );
                        },
                        childCount: snapshot.data!.docs.length,
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
