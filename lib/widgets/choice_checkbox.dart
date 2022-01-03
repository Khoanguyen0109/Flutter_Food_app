import 'package:flutter/material.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';

class CheckBoxChoice extends StatefulWidget {
  @override
  _CheckBoxChoiceState createState() => _CheckBoxChoiceState();
}

class _CheckBoxChoiceState extends State<CheckBoxChoice> {
  bool? _value = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: CheckboxListTile(
              checkColor: Colors.white,
              activeColor: primaryColor,
              contentPadding: EdgeInsets.zero,
              title: Text("title"),
              value: _value,
              onChanged: (newValue) {
                setState(() {
                  _value = newValue;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
          SizedBox(width: 10),
          Text("${CURRENCY}2.00",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textDarkColor)),
        ],
      ),
    );
  }
}