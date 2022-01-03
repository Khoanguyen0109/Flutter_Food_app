import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/services/app_localizations.dart';

class PaymentMethod extends StatefulWidget {
  int? paymemtMethod;
  void Function(int)? selectPaymentMethod;

  PaymentMethod({
    Key? key,
    this.paymemtMethod,
    this.selectPaymentMethod,
  }) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int selectedId = -1;
  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        leading: Center(
          child: Container(
            width: 35,
            height: 35,
            margin: const EdgeInsetsDirectional.only(start: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
                ),
                child: Icon(Icons.navigate_before, color: Colors.black),
                onPressed: () => Navigator.pop(context)),
          ),
        ),
        title: Text(AppLocalizations.of(context)!.translate('payment_method')!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: textDarkColor)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Scrollbar(
                  isAlwaysShown:
                      (deviceType == DeviceType.MOBILE) ? false : true,
                  child: ListView(
                    children: [
                      buildSeparator(),
                      buildItem(
                          AppLocalizations.of(context)!
                              .translate('cash_on_delivery')!,
                          FontAwesomeIcons.moneyBill,
                          1),
                      buildSeparator(),
                      buildItem(
                          AppLocalizations.of(context)!
                              .translate('credit_card')!,
                          FontAwesomeIcons.creditCard,
                          2),
                      buildSeparator(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(String title, IconData icon, int id) {
    return InkWell(
      onTap: () {
        setState(() => selectedId = id);
        if (widget.selectPaymentMethod != null) {
          widget.selectPaymentMethod!(id);
        }
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(width: 20),
            Expanded(
              child: Text(title,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: textDarkColor)),
            ),
            if (widget.paymemtMethod == id) ...[
              SizedBox(width: 20),
              Icon(FontAwesomeIcons.checkCircle, color: successColor),
            ]
          ],
        ),
      ),
    );
  }

  Widget buildSeparator() {
    return Divider(height: 1, thickness: 1, color: lineColor);
  }
}
