import 'package:flutter/material.dart';
import 'container_decoration.dart';

class SimpleAppbar extends StatelessWidget with PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  final String? title;
  SimpleAppbar({this.bottom, this.title});

    @override
  Size get preferredSize => bottom == null
      ? Size(double.infinity, AppBar().preferredSize.height)
      : Size(double.infinity, AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title.toString()),
      flexibleSpace: Container(
        decoration: const ContainerDecoration().decoaration(),
      ),
    );
  }
}
