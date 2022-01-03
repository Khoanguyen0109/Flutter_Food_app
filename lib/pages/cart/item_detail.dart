import 'package:flutter/material.dart';
import 'package:food_app/services/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/services/cart_provider.dart';
import 'package:food_app/widgets/back_button.dart';
import 'package:food_app/widgets/choice_checkbox.dart';
import 'package:food_app/widgets/choice_counterbox.dart';
import 'package:food_app/widgets/choice_multi_radiobox.dart';
import 'package:food_app/widgets/choice_radiobox.dart';
import 'package:food_app/widgets/dotted_line.dart';
import 'package:provider/provider.dart';

class ItemDetail extends StatefulWidget {
  final ItemModel? itemModel;
  ItemDetail(this.itemModel);

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  int quaytity = 1;

  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Scrollbar(
              isAlwaysShown: (deviceType == DeviceType.MOBILE) ? false : true,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 50),
                  Image.asset(widget.itemModel!.image,
                      height: 200, fit: BoxFit.fitHeight),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsetsDirectional.only(
                        start: 20, end: 20, bottom: 70),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20)
                        ],
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(CONTAINER_RADIUS),
                            topEnd: Radius.circular(CONTAINER_RADIUS)),
                        color: Colors.white),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Material(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(widget.itemModel!.title,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                        color: textDarkColor)),
                              ),
                              SizedBox(width: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(CURRENCY,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                          color: primaryColor)),
                                  Text(
                                      widget.itemModel!.price
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                          color: textDarkColor)),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/icon_star.png",
                                        width: 18, height: 18),
                                    SizedBox(width: 8),
                                    Expanded(
                                        child: Text(
                                            widget.itemModel!.reviews
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: textDarkColor))),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/icon_fire.png",
                                        width: 18, height: 18),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                          "${widget.itemModel!.calories} ${AppLocalizations.of(context)!.translate('calories')}",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: textDarkColor)),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        "assets/images/icon_alarm_clock.png",
                                        width: 18,
                                        height: 18),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(widget.itemModel!.time,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: textDarkColor)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                              AppLocalizations.of(context)!
                                  .translate('description')!,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: textDarkColor)),
                          SizedBox(height: 10),
                          Text(widget.itemModel!.description,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: textLightColor)),
                          SizedBox(height: 20),
                          Text(
                              AppLocalizations.of(context)!
                                  .translate('choices')!,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: textDarkColor)),
                          DottedLine(dashWidth: 5, color: textLightColor),
                          CounterBoxChoice(
                            currentValue: quaytity,
                            maxValue: 6,
                            price: widget.itemModel!.price * quaytity,
                            onAdd: () {
                              if (quaytity < 100) {
                                setState(() {
                                  quaytity = quaytity + 1;
                                });
                              }
                            },
                            onMinus: () {
                              if (quaytity > 1) {
                                setState(() {
                                  quaytity = quaytity - 1;
                                });
                              }
                            },
                          ),
                          DottedLine(dashWidth: 5, color: textLightColor),
                          SizedBox(height: 20),
                          Text(
                              AppLocalizations.of(context)!
                                  .translate('choices')!,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: textDarkColor)),
                          CheckBoxChoice(),
                          RadioBoxChoice(widget.itemModel!.choicesList![0]),
                          DottedLine(dashWidth: 5, color: textLightColor),
                          MultiRadioBoxChoice(
                              widget.itemModel!.choicesList![0]),
                          DottedLine(dashWidth: 5, color: textLightColor),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text('Total Item Price:',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: textDarkColor)),
                                ),
                                SizedBox(width: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(CURRENCY,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.5,
                                            color: primaryColor)),
                                    Text("215",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.5,
                                            color: textDarkColor)),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (deviceType == DeviceType.WEB) ? SizedBox() : MyBackButton(),
                  IconButton(
                    icon: Image.asset("assets/images/icon_heart.png",
                        width: 22, height: 22),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.all(10),
                child: FloatingActionButton(
                  heroTag: "add_btn",
                  backgroundColor: primaryColor,
                  child: Icon(Icons.add, size: 30, color: Colors.white),
                  elevation: 12,
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addItem(widget.itemModel!, quaytity);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
