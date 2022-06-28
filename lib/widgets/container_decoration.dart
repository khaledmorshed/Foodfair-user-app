import 'package:flutter/material.dart';

import '../global/color_manager.dart';

class ContainerDecoration extends StatelessWidget {
  const ContainerDecoration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: double.infinity,
        decoration: decoaration(),
      ),
    );
  }

  BoxDecoration decoaration() {
    return BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorManager.purple2,
            ColorManager.cyan2,
          ],
          // begin: FractionalOffset(0.0, 1.0),
          // end: FractionalOffset(1.0, 0.0),
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          //stops: [0.0, 1.0],
          //tileMode: TileMode.clamp
        ),
      );
  }
}