import 'package:flutter/material.dart';
import 'package:foodfair/models/items_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartWidget extends StatefulWidget {
  final ItemModel? itemModel;
  final BuildContext? context;
  final int? quantityNumber;
  final double? total;

  const CartWidget({
    Key? key,
    this.itemModel,
    this.context,
    this.quantityNumber,
    this.total,
  }) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  // double? price = widget.itemModel!.price;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
      child: InkWell(
        child: Card(
          //color: Colors.red,
          // height: 165,
          // width: MediaQuery.of(context).size.width,
          borderOnForeground: false,
          shape: const RoundedRectangleBorder(
              // side: BorderSide(
              //   color: Colors.white,
              //   width: 2,
              // ),
              // borderRadius: BorderRadius.all(
              //   Radius.circular(10),
              // ),
              ),
          elevation: 10,
          child: Row(
            //mainAxisSize: MainAxisSize.min,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                //color: Colors.blue,
                height: MediaQuery.of(context).size.height * 0.14,
                width: MediaQuery.of(context).size.height * 0.16,
                child: CachedNetworkImage(
                  imageUrl: widget.itemModel!.itemImageUrl!,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  //color: Colors.green,
                  height: MediaQuery.of(context).size.height * 0.14,
                  width: MediaQuery.of(context).size.height * 0.21,
                  child: Column(
                    //mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 3, bottom: 5),
                        child: Text(
                          widget.itemModel!.itemTitle!,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          maxLines: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3, bottom: 5),
                        child: Row(
                          children: [
                            const Text(
                              "Price: ",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            Text(
                              widget.itemModel!.price.toString(),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3, bottom: 5),
                        child: Row(
                          children: [
                            const Text(
                              "Total: ",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            Text(
                              "${widget.itemModel!.price! * widget.quantityNumber!}",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                //color: Colors.red,
                height: MediaQuery.of(context).size.height * 0.14,
                width: MediaQuery.of(context).size.height * 0.07,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "x ",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Text(
                        "${widget.quantityNumber.toString()}",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
