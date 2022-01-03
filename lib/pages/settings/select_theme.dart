import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/services/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/widgets/resolution_not_supported.dart';

class SelectTheme extends StatefulWidget {
  @override
  _SelectThemeState createState() => _SelectThemeState();
}

class _SelectThemeState extends State<SelectTheme> {
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
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1), blurRadius: 10)
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
        ),
        body: Scrollbar(
            isAlwaysShown: (deviceType == DeviceType.MOBILE) ? false : true,
            child: _buildBody(deviceType)));
  }

  Widget _buildBody(DeviceType deviceType) {
    if (deviceType == DeviceType.WEB || deviceType == DeviceType.TABLET) {
      return ListView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          Text(
            AppLocalizations.of(context)!.translate('select_theme')!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: textMidColor),
          ),
          SizedBox(height: 30),
          colorButton(Color(0xFFD51965), 'Pink', deviceType),
          SizedBox(height: 20),
          colorButton(Color(0xFFF9C240), 'Lemon', deviceType),
          SizedBox(height: 20),
          colorButton(Color(0xFFF86325), 'Orange', deviceType),
          SizedBox(height: 20),
          colorButton(Color(0xFF603bd1), 'Purple', deviceType),
          SizedBox(height: 20),
          colorButton(Color(0xFF0C55BC), 'Blue', deviceType),
          SizedBox(height: 20),
          colorButton(Color(0xFFD73C21), 'Red', deviceType),
          SizedBox(height: 30),
        ],
      );
    } else if (deviceType == DeviceType.MOBILE) {
      return ListView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          Text(
            AppLocalizations.of(context)!.translate('select_theme')!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: textMidColor),
          ),
          SizedBox(height: 30),
          colorButton(Color(0xFFD51965), 'Pink', deviceType),
          SizedBox(height: 20),
          colorButton(Color(0xFFF9C240), 'Lemon', deviceType),
          SizedBox(height: 20),
          colorButton(Color(0xFFF86325), 'Orange', deviceType),
          SizedBox(height: 20),
          colorButton(Color(0xFF603bd1), 'Purple', deviceType),
          SizedBox(height: 20),
          colorButton(Color(0xFF0C55BC), 'Blue', deviceType),
          SizedBox(height: 20),
          colorButton(Color(0xFFD73C21), 'Red', deviceType),
          SizedBox(height: 30),
        ],
      );
    } else
      return screenSizeNotSupported(context);
  }

  Widget colorButton(Color color, String title, DeviceType deviceType) {
    return Center(
      child: Container(
        width: (deviceType != DeviceType.MOBILE)
            ? WEB_FIXED_WIDTH
            : double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                  vertical: (deviceType != DeviceType.MOBILE) ? 20 : 15)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BORDER_RADIUS),
              )),
              elevation: MaterialStateProperty.all(12),
              backgroundColor: MaterialStateProperty.all(color),
              textStyle:
                  MaterialStateProperty.all(TextStyle(color: Colors.white))),
          child: Text(title,
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 1)),
          onPressed: () {
            primaryColor = color;
            Navigator.pushNamed(context, "/walk_through");
          },
        ),
      ),
    );
  }
}
