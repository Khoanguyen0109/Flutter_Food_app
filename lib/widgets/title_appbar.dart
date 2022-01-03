import 'package:flutter/material.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/services/app_localizations.dart';

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(AppLocalizations.of(context)!.translate(title)!,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: textDarkColor));
  }
}
