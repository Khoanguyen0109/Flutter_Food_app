import 'package:flutter/material.dart';
import 'package:food_app/configs/colors.dart';

class DetailRow extends StatelessWidget {
  final String title;
  final String value;
  const DetailRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: textMidColor)),
        SizedBox(width: 10),
        Expanded(
          child: Text(value,
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textDarkColor)),
        ),
      ],
    );
  }
}
