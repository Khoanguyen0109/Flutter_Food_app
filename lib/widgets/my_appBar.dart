import 'package:flutter/material.dart';

import 'package:food_app/configs/colors.dart';
import 'package:food_app/widgets/back_button.dart';
import 'package:food_app/widgets/title_appbar.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        leading: Center(child: MyBackButton()),
        title: TitleAppBar(
          title: title,
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(20);
}
