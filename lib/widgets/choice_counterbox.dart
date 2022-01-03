import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';

// ignore: must_be_immutable
class CounterBoxChoice extends StatefulWidget {
  final int minValue;
  final int maxValue;
  int currentValue;
  double price;
  final VoidCallback onAdd;
  final VoidCallback onMinus;

  CounterBoxChoice({
    Key? key,
    this.minValue = 0,
    this.maxValue = 100,
    this.currentValue = 0,
    required this.price,
    required this.onAdd,
    required this.onMinus,
  }) : super(key: key);
  @override
  _CounterBoxChoiceState createState() => _CounterBoxChoiceState();
}

class _CounterBoxChoiceState extends State<CounterBoxChoice> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            height: 35,
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              child:
                  Icon(FontAwesomeIcons.minus, size: 14, color: primaryColor),
              onPressed: () {
                widget.onMinus();
                // setState(() {
                //   if (widget.currentValue > widget.minValue)
                //     widget.currentValue--;
                // });
              },
            ),
          ),
          Text(widget.currentValue.toString(),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: primaryColor)),
          // Container(width: 1, height: 20, color: textLightColor),
          SizedBox(
            width: 40,
            height: 35,
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              child: Icon(FontAwesomeIcons.plus, size: 14, color: primaryColor),
              onPressed: () {
                widget.onAdd();

                // setState(() {
                //   if (widget.currentValue < widget.maxValue)
                //     widget.currentValue++;
                // });
              },
            ),
          ),
          SizedBox(width: 10),
          Expanded(child: Container()),
          Text("${CURRENCY} ${widget.price}",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textDarkColor)),
        ],
      ),
    );
  }
}
