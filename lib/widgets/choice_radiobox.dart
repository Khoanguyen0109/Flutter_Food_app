import 'package:flutter/material.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/models/models.dart';

class RadioBoxChoice extends StatefulWidget {
  final ChoiceModel choiceModel;
  RadioBoxChoice(this.choiceModel);

  @override
  _RadioBoxChoiceState createState() => _RadioBoxChoiceState();
}

class _RadioBoxChoiceState extends State<RadioBoxChoice> {
  int? _value = -1;

  @override
  Widget build(BuildContext context) {
    final arrayList = widget.choiceModel.subChoicesList!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20),
        Text(widget.choiceModel.title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textDarkColor)),
        ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 5),
            scrollDirection: Axis.vertical,
            itemCount: arrayList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  _onValueChanged(arrayList[index].id);
                },
                child: Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 8, 0, 8),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: Radio(
                          value: arrayList[index].id,
                          groupValue: _value,
                          onChanged: _onValueChanged,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(arrayList[index].title,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: textDarkColor)),
                      ),
                      SizedBox(width: 10),
                      Text(
                          "$CURRENCY${arrayList[index].price.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textDarkColor)),
                    ],
                  ),
                ),
              );
            }),
        SizedBox(height: 10),
      ],
    );
  }

  _onValueChanged(id) {
    setState(() => _value = id);
  }
}
