import 'package:flutter/material.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/utils/utils.dart';
import 'package:food_app/widgets/order_status.dart';
import 'package:provider/provider.dart';

class OrderRow extends StatelessWidget {
  const OrderRow({
    Key? key,
    required this.orderModel,
  }) : super(key: key);

  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AuthProvider>(context).getUser;
    String? role = user.role;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/order', arguments: orderModel.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20)
          ],
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OrderStatusView(status: orderModel.status),
                        Text(Utils.formatDateTime(orderModel.createdAt),
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                                color: textDarkColor))
                      ],
                    ),
                    Text(orderModel.storeModel?.name ?? '',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            color: textDarkColor)),
                    Text(orderModel.storeModel?.name ?? '',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: textLightColor)),
                    SizedBox(height: 5),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(CURRENCY,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                        color: primaryColor)),
                                Text(orderModel.total.toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                        color: textDarkColor)),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Visibility(
                              visible: role == 'shipper' &&
                                  orderModel.status == OrderStatus.PREPARING,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.all(10)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            BORDER_RADIUS),
                                      )),
                                      elevation: MaterialStateProperty.all(12),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              primaryColor),
                                      textStyle: MaterialStateProperty.all(
                                          TextStyle(color: Colors.white))),
                                  child: Text('Take Order',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1,
                                          color: Colors.white)),
                                  onPressed: () {}),
                            ),
                            Visibility(
                              visible: role == 'shipper' &&
                                  orderModel.status == OrderStatus.DELIVERING,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.all(10)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            BORDER_RADIUS),
                                      )),
                                      elevation: MaterialStateProperty.all(12),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              primaryColor),
                                      textStyle: MaterialStateProperty.all(
                                          TextStyle(color: Colors.white))),
                                  child: Text('Deliverd',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1,
                                          color: Colors.white)),
                                  onPressed: () {}),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
