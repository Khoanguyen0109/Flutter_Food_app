import 'package:flutter/material.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/models/models.dart';

class MultiRadioBoxChoice extends StatefulWidget {
  final ChoiceModel choiceModel;
  MultiRadioBoxChoice(this.choiceModel);

  @override
  _MultiRadioBoxChoiceState createState() => _MultiRadioBoxChoiceState();
}

class _MultiRadioBoxChoiceState extends State<MultiRadioBoxChoice> {
  List<int?> _values = [];

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
              final selectedValue = _values.firstWhere(
                  (element) => element == arrayList[index].id,
                  orElse: () => -1);

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
                          groupValue: selectedValue,
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

  _onValueChanged(value) {
    final id =
        _values.firstWhere((element) => element == value, orElse: () => -1);
    if (id == -1)
      setState(() => _values.add(value));
    else
      setState(() => _values.remove(value));
  }
}
