import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:food_app/pages/order/widgets/perpare_order.dart';
import 'package:food_app/services/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/widgets/circular_progress_bar.dart';
import 'package:food_app/widgets/dotted_line.dart';

class OrderTracking1 extends StatefulWidget {
  @override
  _OrderTracking1State createState() => _OrderTracking1State();
}

class _OrderTracking1State extends State<OrderTracking1> {
  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);

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
                      PrepareOrder(),
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
                            onPressed: () => Navigator.pop(context)),
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
