import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodfair/screens/user_menus_screen.dart';
import 'package:foodfair/models/sellers_model.dart';

import '../global/color_manager.dart';
import 'loading_container.dart';

class SellerProfileDesign extends StatefulWidget {
  Sellers? sellerModel;
  BuildContext? context;
  bool? netValue;
  SellerProfileDesign({Key? key, this.sellerModel, this.context, this.netValue})
      : super(key: key);

  @override
  State<SellerProfileDesign> createState() => _SellerProfileDesignState();
}

class _SellerProfileDesignState extends State<SellerProfileDesign> {
  bool isLoading = false;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    String address = widget.sellerModel!.address.toString();
    // for (int i = 0; i < address.length; i++) {
    //   if (address[i] == ',') {
    //     count++;
    //   }
    // }

    var _splitAdrress = address.split(",")[1];
    var _splitAdrress2 = address.split(",")[2];

    return Padding(
      padding: EdgeInsets.only(top: 10, left: 15, right: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserMenusScreen(
                        sellerModel: widget.sellerModel,
                      )));
        },
        splashColor: Colors.red,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: /*Image.network(
                      widget.sellerModel!.sellerAvatarUrl!,
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),*/
                  widget.sellerModel!.sellerAvatarUrl == null
                      ? Container(
                          color: ColorManager.purple1,
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                              child: Text(
                            "Image not found", /*style: TextStyle(height: ),*/
                          )))
                      :/* widget.netValue == false
                          ? LoadingContainer()
                          : */
                     /* Image.network(
                          widget.sellerModel!.sellerAvatarUrl!,
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: /*CircularProgressIndicator*/ LoadingContainer(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),*/

                    CachedNetworkImage(
                      imageUrl: widget.sellerModel!.sellerAvatarUrl!,
                      placeholder: (context, url) =>
                          Center(child: LoadingContainer()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 0, top: 8),
                child: widget.sellerModel!.sellerName == null
                    ? const Text(
                        "Name not found",
                      )
                    : Text(
                        widget.sellerModel!.sellerName!,
                        style: TextStyle(fontSize: 20),
                      )),
            Row(
              children: [
                Text(
                  "${_splitAdrress}, ",
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "${_splitAdrress2}",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
