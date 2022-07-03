import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodfair/models/items_model.dart';
import 'package:foodfair/models/menus_model.dart';
import 'package:foodfair/widgets/items_widget.dart';
import 'package:provider/provider.dart';
import '../providers/sellers_provider.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_container.dart';
import '../widgets/my_appbar.dart';
import '../widgets/text_widget_header.dart';

class UserItemsScreen extends StatefulWidget {
  final MenusModel? model;
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
  late SellersProvider _sellersProvider;
  bool _init = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      _sellersProvider = Provider.of<SellersProvider>(context, listen: false);
      _sellersProvider
          .fetchSpecificSellerItems(widget.sellerUID!, widget.model!.menuID!)
          .then((value) {
        setState(() {
          _init = false;
        });
      });
    }
  }

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
            stream: _sellersProvider.specificSellerItems,
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
                          ItemModel itemModel = ItemModel.fromJson(
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
