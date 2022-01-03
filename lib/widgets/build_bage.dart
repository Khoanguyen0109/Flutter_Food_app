import 'package:flutter/material.dart';
import 'package:food_app/configs/colors.dart';

class BuildBage extends StatelessWidget {
  const BuildBage({
    Key? key,
    required this.count,
  }) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    if (count > 0) {
      return Align(
        alignment: AlignmentDirectional.topEnd,
        child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4)
          ], borderRadius: BorderRadius.circular(12), color: textMidColor),
          child: Center(
              child: Text(count.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14))),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
