import 'package:flutter/material.dart';
import 'package:food_app/services/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';

showDeliveryNoteDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);

        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                    width: (deviceType == DeviceType.WEB ||
                            deviceType == DeviceType.TABLET)
                        ? WEB_FIXED_WIDTH
                        : double.infinity,
                    height: 300,
                    child: Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    AppLocalizations.of(context)!
                                        .translate('delivery_instructions')!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                        color: textDarkColor)),
                                SizedBox(height: 10),
                                TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 12),
                                    hintText: AppLocalizations.of(context)!
                                        .translate("enter_instructions_here"),
                                    hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: textLightColor),
                                    border: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            BORDER_RADIUS)),
                                  ),
                                  minLines: 4,
                                  maxLines: 4,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: textDarkColor),
                                  keyboardType: TextInputType.multiline,
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              vertical:
                                                  (deviceType == DeviceType.WEB)
                                                      ? 20
                                                      : 15)),
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
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('btn_save')!,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: IconButton(
                            icon: Icon(Icons.cancel,
                                color: textLightColor, size: 25),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ))));
      });
}
