import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../global/color_manager.dart';
import '../models/items_model.dart';
import '../screens/user_items_details_screen.dart';
import 'loading_container.dart';

class ItemsWidget extends StatefulWidget {
  ItemModel? itemModel;
  BuildContext? context;
  bool? netValue;
  String? sellerUID;
  ItemsWidget({
    Key? key,
    this.itemModel,
    this.context,
    this.netValue,
    this.sellerUID,
  }) : super(key: key);
     

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  bool isLoading = false;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      UserItemsDetailsScreen(itemModel: widget.itemModel, sellerUID: widget.sellerUID)));
        },
        splashColor: Colors.red,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Center(
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Text(
            //       "${widget.itemModel!.itemTitle}",
            //       style: TextStyle(fontSize: 18),
            //     ),
            //   ),
            // ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: widget.itemModel!.itemImageUrl == null
                  ? Container(
                      color: ColorManager.purple1,
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                          child: Text(
                        "Image not found", /*style: TextStyle(height: ),*/
                      )))
                  : /*widget.netValue == false
                          ? LoadingContainer()
                          : */
                  /*Image.network(
                      widget.itemModel!.itemImageUrl!,
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: /*CircularProgressIndicator*/ LoadingContainer(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),*/

                  CachedNetworkImage(
                      imageUrl: widget.itemModel!.itemImageUrl!,
                      placeholder: (context, url) =>
                          Center(child: LoadingContainer()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                "${widget.itemModel!.shortInformation}",
                style: TextStyle(fontSize: 16),
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
