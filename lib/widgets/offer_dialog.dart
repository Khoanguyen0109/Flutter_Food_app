import 'package:flutter/material.dart';
import 'package:food_app/services/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/widgets/resolution_not_supported.dart';

showOfferDialog(BuildContext context, String imageURL) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);

        if (deviceType == DeviceType.WEB) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: WEB_FIXED_WIDTH,
                    height: 500,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                            child: Image.asset(imageURL, fit: BoxFit.cover)),
                        Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: IconButton(
                            icon: Icon(Icons.cancel,
                                color: Colors.white, size: 25),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.symmetric(
                                                  vertical: 20)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          )),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  textLightColor),
                                          textStyle: MaterialStateProperty.all(
                                              TextStyle(color: Colors.white))),
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .translate('btn_maybe_later')!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.symmetric(
                                                  vertical: 20)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          )),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          textStyle: MaterialStateProperty.all(
                                              TextStyle(color: primaryColor))),
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .translate('btn_order_now')!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor)),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                  )));
        } else if (deviceType == DeviceType.TABLET ||
            deviceType == DeviceType.MOBILE) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 400,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                            child: Image.asset(imageURL, fit: BoxFit.cover)),
                        Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: IconButton(
                            icon: Icon(Icons.cancel,
                                color: Colors.white, size: 25),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.symmetric(
                                                  vertical: 12)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          )),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  textLightColor),
                                          textStyle: MaterialStateProperty.all(
                                              TextStyle(color: Colors.white))),
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .translate('btn_maybe_later')!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.symmetric(
                                                  vertical: 12)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          )),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          textStyle: MaterialStateProperty.all(
                                              TextStyle(color: primaryColor))),
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .translate('btn_order_now')!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor)),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                  )));
        } else
          return screenSizeNotSupported(context);
      });
}
