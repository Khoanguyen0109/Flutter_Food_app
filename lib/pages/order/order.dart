import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/models/order_item_models.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/pages/order/widgets/find_shipper.dart';
import 'package:food_app/pages/order/widgets/order_item_row.dart';
import 'package:food_app/pages/order/widgets/order_map.dart';
import 'package:food_app/pages/order/widgets/perpare_order.dart';
import 'package:food_app/providers/app_localizations.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/providers/notification_provider.dart';
import 'package:food_app/services/order_services.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/widgets/dotted_line.dart';
import 'package:provider/provider.dart';

class Order extends StatefulWidget {
  final OrderModel order;
  Order({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  int status = 1;
  NotificationProvider? notificationProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationProvider = context.read<NotificationProvider>();
    notificationProvider?.addListener(notificationListener);
  }

  void notificationListener() {
    if (notificationProvider != null) {
      _getOrder(1);
    }
  }

  Future<OrderModel?> _getOrder(id) async {
    print('calll');
    try {
      OrderModel? res = await OrderServices.fetchOrderDetail(id);
      return res;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);
    onBack() {
      Provider.of<AuthProvider>(context, listen: false).backFromOrder();
      Navigator.pushReplacementNamed(context, '/home');
    }

    return Scaffold(
        backgroundColor: backgroundColor,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: [
              Scrollbar(
                isAlwaysShown: (deviceType == DeviceType.MOBILE) ? false : true,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      PrepareOrder(
                        status: status,
                      ),
                      Container(height: 10, color: lineColor),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                "#208"),
                            SizedBox(height: 5),
                            buildDetailRow(
                                AppLocalizations.of(context)!
                                    .translate('delivery_address')!,
                                "Vancouver, BC V6C 2T4"),
                            SizedBox(height: 5),
                            buildDetailRow(
                                AppLocalizations.of(context)!
                                    .translate('phone')!,
                                "Vancouver, BC V6C 2T4"),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: DottedLine(dashWidth: 5, color: lineColor),
                            ),
                            buildDetailRow(
                                '2x Meat Ball Pasta', "${CURRENCY}35"),
                            SizedBox(height: 5),
                            buildDetailRow('1x Steak', "${CURRENCY}20"),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: DottedLine(dashWidth: 5, color: lineColor),
                            ),
                            buildDetailRow(
                                AppLocalizations.of(context)!
                                    .translate('sub_total')!,
                                "${CURRENCY}90"),
                            SizedBox(height: 5),
                            buildDetailRow("$TAX_LABEL ($TAX_PERCENTAGE%)",
                                "${CURRENCY}17"),
                            SizedBox(height: 5),
                            buildDetailRow(
                                AppLocalizations.of(context)!
                                    .translate('delivery_cost')!,
                                AppLocalizations.of(context)!
                                    .translate('free')!),
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
                                  child: Text("${CURRENCY}107",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: textDarkColor)),
                                )
                              ],
                            ),
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
                            SizedBox(height: 20)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                            ),
                            child: Icon(Icons.navigate_before,
                                color: Colors.black),
                            onPressed: () => onBack()),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('208',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
                                    color: Colors.white)),
                            Text(
                                AppLocalizations.of(context)!
                                    .translate('order_no')!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white))
                          ],
                        ),
                      ),
                      SizedBox(width: 35),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
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
