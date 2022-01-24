import 'package:flutter/material.dart';
import 'package:food_app/utils/constants.dart';

class OrderStatusView extends StatelessWidget {
  int status;

  OrderStatusView({
    Key? key,
    required this.status,
  }) : super(key: key);

  get textDarkColor => null;

  renderStatus() {
    if (status == OrderStatus.FINDING) {
      return 'Finding';
    }
    if (status == OrderStatus.PREPARING) {
      return 'Preparing';
    }
    if (status == OrderStatus.DELIVERING) {
      return 'Delivering';
    }
    if (status == OrderStatus.DELIVERD) {
      return 'Deliverd';
    }
    if (status == OrderStatus.REVICED) {
      return 'Recived';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(renderStatus(),
        style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
            color: textDarkColor));
  }
}
