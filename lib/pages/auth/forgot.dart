import 'package:flutter/material.dart';
import 'package:food_app/providers/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/widgets/resolution_not_supported.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
        body: _buildBody(deviceType));
  }

  Widget _buildBody(DeviceType deviceType) {
    if (deviceType == DeviceType.WEB || deviceType == DeviceType.TABLET) {
      return Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: WEB_FIXED_WIDTH,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .translate('forgot_password')!,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: primaryColor),
                      ),
                      SizedBox(height: 10),
                      Text(
                          AppLocalizations.of(context)!
                              .translate('password_reset_description')!,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              color: textMidColor)),
                      SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          labelText:
                              AppLocalizations.of(context)!.translate('email'),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              color: textLightColor),
                        ),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textDarkColor),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(vertical: 20)),
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
                                .translate('btn_send')!,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                                color: Colors.white)),
                        onPressed: () {},
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            )),
      );
    } else if (deviceType == DeviceType.MOBILE) {
      return Scrollbar(
        isAlwaysShown: false,
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .translate('forgot_password')!,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: primaryColor),
                    ),
                    SizedBox(height: 10),
                    Text(
                        AppLocalizations.of(context)!
                            .translate('password_reset_description')!,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            color: textMidColor)),
                    SizedBox(height: 30),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        labelText:
                            AppLocalizations.of(context)!.translate('email'),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            color: textLightColor),
                      ),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textDarkColor),
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(vertical: 15)),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(BORDER_RADIUS),
                          )),
                          elevation: MaterialStateProperty.all(12),
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(color: Colors.white))),
                      child: Text(
                          AppLocalizations.of(context)!.translate('btn_send')!,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: Colors.white)),
                      onPressed: () {},
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            )),
      );
    } else
      return screenSizeNotSupported(context);
  }
}
