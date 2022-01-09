import 'package:flutter/material.dart';
import 'package:food_app/providers/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);

    return Scaffold(
      backgroundColor: backgroundColor,
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
        title: Text(AppLocalizations.of(context)!.translate('notifications')!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: textDarkColor)),
      ),
      body: Scrollbar(
        isAlwaysShown: (deviceType == DeviceType.MOBILE) ? false : true,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            listItem('Account Creation',
                "Thanks for creating your account with us.", "23 Jun, 2020"),
            listItem('Order Success',
                "Your order has been placed successfully.", "02 Jul, 2020"),
            listItem(
                'Order Delivered',
                "Your order has been delivered at your doorstep. For any issue contact us",
                "14 Jul, 2020"),
          ],
        ),
      ),
    );
  }

  Widget listItem(String title, String description, String datetime) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)
      ], borderRadius: BorderRadius.circular(12), color: Colors.white),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Icon(Icons.notifications, size: 30, color: textLightColor),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                          color: primaryColor)),
                  SizedBox(height: 5),
                  Text(description,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                          color: textMidColor)),
                  SizedBox(height: 5),
                  Text(datetime,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                          color: textMidColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
