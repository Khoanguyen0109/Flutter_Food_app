import 'package:flutter/material.dart';
import 'package:food_app/configs/configs.dart';

import 'package:food_app/models/order_item_models.dart';

class OrderItemRow extends StatelessWidget {
  const OrderItemRow({
    Key? key,
    required this.orderItem,
  }) : super(key: key);
  final OrderItem orderItem;

  get textMidColor => null;

  get textDarkColor => null;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(orderItem.quantity.toString() + 'x',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: textMidColor)),
            SizedBox(width: 10),
            Text(orderItem.item.name,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: textMidColor)),
          ],
        ),
        Expanded(
          child: Text(
              (orderItem.item.price * orderItem.quantity).toString() +
                  "$CURRENCY",
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
