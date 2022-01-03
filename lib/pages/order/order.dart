import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/models/order_item_models.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/pages/order/widgets/find_shipper.dart';
import 'package:food_app/pages/order/widgets/order_item_row.dart';
import 'package:food_app/pages/order/widgets/order_map.dart';
import 'package:food_app/pages/order/widgets/perpare_order.dart';
import 'package:food_app/services/app_localizations.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/widgets/dotted_line.dart';

class Order extends StatefulWidget {
  Order({Key? key}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  late OrderModel order = new OrderModel(
      id: 1,
      deliveryAddress: "422 nguyen thi thap",
      orderItems: [
        new OrderItem(
            quantity: 3,
            item: ItemModel(
                1,
                'Meat Ball Pasta',
                'Spicy Meat Ball Pasta',
                'assets/images/temp_item1.png',
                25,
                3.5,
                175.00,
                "20-30 min",
                null),
            totalPrice: 122)
      ],
      delyveryCost: 2,
      itemCost: 122,
      total: 133,
      paymentMethod: 0,
      status: OrderStatus.FINDING);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);

    return Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: Scrollbar(
                isAlwaysShown: (deviceType == DeviceType.MOBILE) ? false : true,
                child: Column(children: [
                  renderByOrderStatus(),
                  Container(height: 10, color: lineColor),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                            AppLocalizations.of(context)!
                                .translate('order_details')!,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: textDarkColor)),
                        SizedBox(height: 10),
                        buildDetailRow(
                            AppLocalizations.of(context)!
                                .translate('your_order_number')!,
                            order.id.toString()),
                        SizedBox(height: 5),
                        buildDetailRow(
                            AppLocalizations.of(context)!
                                .translate('delivery_address')!,
                            order.deliveryAddress),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: DottedLine(dashWidth: 5, color: lineColor),
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return OrderItemRow(
                                  orderItem: order.orderItems[index]);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 2);
                            },
                            itemCount: order.orderItems.length),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: DottedLine(dashWidth: 5, color: lineColor),
                        ),
                        buildDetailRow(
                            AppLocalizations.of(context)!
                                .translate('sub_total')!,
                            "${order.itemCost} ${CURRENCY} "),
                        SizedBox(height: 5),
                        buildDetailRow(
                            AppLocalizations.of(context)!
                                .translate('delivery_cost')!,
                            order.delyveryCost != 0
                                ? order.delyveryCost.toString()
                                : AppLocalizations.of(context)!
                                    .translate('free')!),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: DottedLine(dashWidth: 5, color: lineColor),
                        ),
                        buildDetailRow(
                            AppLocalizations.of(context)!
                                .translate('payment_method')!,
                            AppLocalizations.of(context)!
                                .translate('cash_on_delivery')!),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: DottedLine(dashWidth: 5, color: lineColor),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                AppLocalizations.of(context)!
                                    .translate('total_inclusive_tax')!,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: textDarkColor)),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text("${order.total} ${CURRENCY}",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: textDarkColor)),
                            )
                          ],
                        ),
                        SizedBox(height: 20)
                      ],
                    ),
                  )
                ]),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 24)
                      ],
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        vertical: (deviceType == DeviceType.WEB)
                                            ? 20
                                            : 15)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: primaryColor,
                                      width: 1.5,
                                      style: BorderStyle.solid),
                                  borderRadius:
                                      BorderRadius.circular(BORDER_RADIUS),
                                )),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(color: primaryColor))),
                            child: Text(
                                AppLocalizations.of(context)!
                                    .translate('btn_cancel')!,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        vertical: (deviceType == DeviceType.WEB)
                                            ? 20
                                            : 15)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(BORDER_RADIUS),
                                )),
                                elevation: MaterialStateProperty.all(12),
                                backgroundColor:
                                    MaterialStateProperty.all(primaryColor),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(color: Colors.white))),
                            child: Text(
                                AppLocalizations.of(context)!
                                    .translate('btn_return_home')!,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1)),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/home');
                            },
                          ),
                        ),
                      ],
                    )))
          ],
        ));
  }

  Widget renderByOrderStatus() {
    if (order.status == OrderStatus.FINDING) {
      return FindingShipper();
    }
    if (order.status == OrderStatus.PREPARING) {
      return PrepareOrder();
    }
    if (order.status == OrderStatus.DELIVERD) {
      // return OrderMap();
    }
    return Container();
  }

  buildDetailRow(String title, String value) {
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
