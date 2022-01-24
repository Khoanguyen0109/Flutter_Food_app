import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CounterButton extends StatefulWidget {
  final int minValue;
  final int maxValue;
  bool? cartUpdate;
  Function? updateCartItem;
  int currentValue;
  CounterButton(
      {this.currentValue = 0,
      this.minValue = 0,
      this.maxValue = 100,
      this.cartUpdate,
      this.updateCartItem});
  @override
  _CounterButtonState createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 5)
          ],
          borderRadius: BorderRadius.circular(CONTAINER_RADIUS),
          color: primaryColor),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              child:
                  Icon(FontAwesomeIcons.minus, size: 10, color: Colors.white),
              onPressed: () {
                if (widget.cartUpdate != null) {
                  widget.updateCartItem!(widget.currentValue - 1);
                } else {
                  setState(() {
                    if (widget.currentValue > widget.minValue)
                      widget.currentValue--;
                  });
                }
              },
            ),
          ),
          Expanded(
            child: Text(widget.currentValue.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
          ),
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              child: Icon(FontAwesomeIcons.plus, size: 10, color: Colors.white),
              onPressed: () {
                if (widget.cartUpdate != null) {
                  widget.updateCartItem!(widget.currentValue + 1);
                } else {
                  setState(() {
                    if (widget.currentValue < widget.maxValue)
                      widget.currentValue++;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
