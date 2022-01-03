import 'package:flutter/material.dart';
import 'package:food_app/services/app_localizations.dart';
import 'package:food_app/configs/colors.dart';

Widget screenSizeNotSupported(BuildContext context) {
  return Container(
    child: Center(
        child: Text(
            AppLocalizations.of(context)!
                .translate('screen_size_not_supported')!,
            style: TextStyle(
                fontSize: 25,
                color: textDarkColor,
                fontWeight: FontWeight.w600))),
  );
}
