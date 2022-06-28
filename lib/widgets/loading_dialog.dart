import 'package:flutter/material.dart';
import 'package:foodfair/widgets/progress_bar.dart';
class LoadingDailog extends StatelessWidget {
  final String? message;
  LoadingDailog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circularProgress(),
          SizedBox(height: 10,),
          Text(message!+ ", please wait..."),
        ],
      ),
    );
  }
}
