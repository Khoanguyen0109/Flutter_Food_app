import 'package:flutter/material.dart';
import 'package:food_app/providers/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';

class LabelBox extends StatefulWidget {
  @override
  _LabelBoxState createState() => _LabelBoxState();
}

class _LabelBoxState extends State<LabelBox> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildLabel(AppLocalizations.of(context)!.translate('label_home')!, 0),
        SizedBox(width: 10),
        buildLabel(AppLocalizations.of(context)!.translate('label_work')!, 1),
        SizedBox(width: 10),
        buildLabel(AppLocalizations.of(context)!.translate('label_other')!, 2)
      ],
    );
  }

  Widget buildLabel(String title, int id) {
    return Expanded(
      child: TextButton(
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            side: BorderSide(
                color: (value == id) ? primaryColor : textMidColor,
                width: 1.5,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(CONTAINER_RADIUS),
          )),
        ),
        child: Text(title,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: (value == id) ? primaryColor : textMidColor)),
        onPressed: () {
          setState(() => value = id);
        },
      ),
    );
  }
}
