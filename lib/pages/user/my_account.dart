import 'package:flutter/material.dart';
import 'package:food_app/providers/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';

class MyAccount extends StatelessWidget {
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
          title: Text(AppLocalizations.of(context)!.translate('my_account')!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textDarkColor)),
        ),
        body: Center(
          child: Scrollbar(
            isAlwaysShown: (deviceType == DeviceType.MOBILE) ? false : true,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            controller: TextEditingController(text: "Sohail"),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(0),
                              labelText: AppLocalizations.of(context)!
                                  .translate('first_name'),
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5,
                                  color: textLightColor),
                            ),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: textDarkColor),
                            textCapitalization: TextCapitalization.words),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                            controller: TextEditingController(text: "Asghar"),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(0),
                              labelText: AppLocalizations.of(context)!
                                  .translate('last_name'),
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5,
                                  color: textLightColor),
                            ),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: textDarkColor),
                            textCapitalization: TextCapitalization.words),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                      controller: TextEditingController(
                          text: "ahmed.sohail.asghar@gmail.com"),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        labelText: AppLocalizations.of(context)!
                            .translate('email_address'),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            color: textLightColor),
                      ),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textDarkColor),
                      textCapitalization: TextCapitalization.words),
                  SizedBox(height: 20),
                  TextFormField(
                      controller:
                          TextEditingController(text: "+92-313-1234567"),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        labelText:
                            AppLocalizations.of(context)!.translate('mobile'),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            color: textLightColor),
                      ),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textDarkColor),
                      textCapitalization: TextCapitalization.words),
                  SizedBox(height: 20),
                  TextFormField(
                      controller: TextEditingController(text: "23-03-1993"),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        labelText: AppLocalizations.of(context)!
                            .translate('date_of_birth'),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            color: textLightColor),
                      ),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textDarkColor),
                      textCapitalization: TextCapitalization.words),
                  SizedBox(height: 50),
                  ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            vertical:
                                (deviceType == DeviceType.WEB) ? 20 : 15)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(BORDER_RADIUS),
                        )),
                        elevation: MaterialStateProperty.all(12),
                        backgroundColor:
                            MaterialStateProperty.all(primaryColor),
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: Colors.white))),
                    child: Text(
                        AppLocalizations.of(context)!.translate('btn_update')!,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ));
  }
}
