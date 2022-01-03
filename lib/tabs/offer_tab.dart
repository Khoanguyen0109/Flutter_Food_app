import 'package:flutter/material.dart';
import 'package:food_app/configs/GridFixedHeightDelegate.dart';
import 'package:food_app/services/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/pages/cart/item_detail.dart';
import 'package:food_app/widgets/item_row.dart';
import 'package:food_app/widgets/resolution_not_supported.dart';

class OfferTab extends StatefulWidget {
  @override
  _OfferTabState createState() => _OfferTabState();
}

class _OfferTabState extends State<OfferTab> {
  ScrollController _scrollController = new ScrollController();

  List<SubChoiceModel>? _subChoiceList;
  List<ChoiceModel>? _choiceList;
  late List<ItemModel> _offersArray;

  @override
  void initState() {
    super.initState();

    _subChoiceList = [
      SubChoiceModel(1, 'Meat Ball Pasta', 5.00),
      SubChoiceModel(2, 'Meat', 9.00),
      SubChoiceModel(3, 'Ball Pasta', 0),
      SubChoiceModel(4, 'Cheese', 8.00),
    ];

    _choiceList = [
      ChoiceModel(1, 'Meat Ball Pasta', _subChoiceList),
      ChoiceModel(2, 'Meat', _subChoiceList),
      ChoiceModel(3, 'Ball Pasta', _subChoiceList),
      ChoiceModel(4, 'Cheese', _subChoiceList),
    ];

    _offersArray = [
      ItemModel(
          1,
          'Meat Ball Pasta',
          'Spicy Meat Ball Pasta',
          'assets/images/temp_item1.png',
          25,
          3.5,
          175.00,
          "20-30 min",
          _choiceList),
      ItemModel(
          2,
          'Steak',
          'Special Beef Steak',
          'assets/images/temp_item2.png',
          32,
          4.5,
          190.00,
          "30-35 min",
          _choiceList),
      ItemModel(
          3,
          'Tomato Pizza',
          'Tomato Cheese Pizza',
          'assets/images/temp_item3.png',
          45,
          1.2,
          210.00,
          "45-50 min",
          _choiceList),
      ItemModel(
          4,
          'Double Decker',
          'Special Double Deck Burger',
          'assets/images/temp_item4.png',
          13,
          4.7,
          280.00,
          "15-20 min",
          _choiceList)
    ];
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);

    int gridCount = 0;
    if (deviceType == DeviceType.WEB) {
      final deviceSize = MyClass.getWebSize(MediaQuery.of(context).size);
      gridCount = (deviceSize == DeviceSize.XL) ? 4 : 3;
    }

    if (deviceType == DeviceType.WEB) {
      return SafeArea(
        child: Scrollbar(
          controller: _scrollController,
          isAlwaysShown: true,
          child: GridView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 30),
            gridDelegate: GridFixedHeightDelegate(
              crossAxisCount: gridCount,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              height: 300,
            ),
            children: [
              _gridMenuItem(_offersArray[0]),
              _gridMenuItem(_offersArray[1]),
              _gridMenuItem(_offersArray[2]),
              _gridMenuItem(_offersArray[3]),
            ],
          ),
        ),
      );
    } else if (deviceType == DeviceType.TABLET ||
        deviceType == DeviceType.MOBILE) {
      return SafeArea(
        child: Scrollbar(
          controller: _scrollController,
          isAlwaysShown: (deviceType == DeviceType.MOBILE) ? false : true,
          child: ListView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            children: [
              ItemRow(itemModel: _offersArray[0]),
              ItemRow(itemModel: _offersArray[1]),
              ItemRow(itemModel: _offersArray[2]),
              ItemRow(itemModel: _offersArray[3]),
            ],
          ),
        ),
      );
    } else
      return screenSizeNotSupported(context);
  }

  // Widget _menuItem(ItemModel itemModel) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(vertical: 8),
  //     clipBehavior: Clip.antiAliasWithSaveLayer,
  //     decoration: BoxDecoration(
  //       boxShadow: [
  //         BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20)
  //       ],
  //       borderRadius: BorderRadius.circular(BORDER_RADIUS),
  //       color: Colors.white,
  //     ),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(
  //           width: 115,
  //           child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.stretch,
  //               children: [
  //                 Align(
  //                   alignment: AlignmentDirectional.topStart,
  //                   child: Container(
  //                     width: 90,
  //                     height: 30,
  //                     padding: const EdgeInsets.all(5),
  //                     decoration: BoxDecoration(
  //                       boxShadow: [
  //                         BoxShadow(
  //                             color: Colors.black.withOpacity(0.3),
  //                             blurRadius: 5)
  //                       ],
  //                       color: Colors.white,
  //                     ),
  //                     child: Row(
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //                         Image.asset("assets/images/icon_alarm_clock.png",
  //                             width: 15, height: 15),
  //                         SizedBox(width: 5),
  //                         Expanded(
  //                           child: Text(itemModel.time,
  //                               style: TextStyle(
  //                                   fontSize: 12,
  //                                   fontWeight: FontWeight.w600,
  //                                   color: textDarkColor)),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsetsDirectional.only(start: 15),
  //                   child: Image.asset(itemModel.image,
  //                       width: 100, height: 100, fit: BoxFit.fitHeight),
  //                 ),
  //               ]),
  //         ),
  //         Expanded(
  //           child: Padding(
  //             padding: const EdgeInsets.all(15),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.stretch,
  //               children: [
  //                 Text(itemModel.title,
  //                     style: TextStyle(
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.w600,
  //                         letterSpacing: 0.5,
  //                         color: textDarkColor)),
  //                 Text(itemModel.description,
  //                     style: TextStyle(
  //                         fontSize: 13,
  //                         fontWeight: FontWeight.w400,
  //                         color: textLightColor)),
  //                 SizedBox(height: 5),
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                       child: Row(
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           Image.asset("assets/images/icon_star.png",
  //                               width: 18, height: 18),
  //                           SizedBox(width: 8),
  //                           Expanded(
  //                               child: Text(itemModel.reviews.toString(),
  //                                   style: TextStyle(
  //                                       fontSize: 13,
  //                                       fontWeight: FontWeight.w600,
  //                                       color: textDarkColor))),
  //                         ],
  //                       ),
  //                     ),
  //                     Expanded(
  //                       child: Row(
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           Image.asset("assets/images/icon_fire.png",
  //                               width: 18, height: 18),
  //                           SizedBox(width: 8),
  //                           Expanded(
  //                             child: Text(
  //                                 "${itemModel.calories} ${AppLocalizations.of(context)!.translate('calories')}",
  //                                 style: TextStyle(
  //                                     fontSize: 13,
  //                                     fontWeight: FontWeight.w600,
  //                                     color: textDarkColor)),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(height: 10),
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Text(CURRENCY,
  //                                 style: TextStyle(
  //                                     fontSize: 17,
  //                                     fontWeight: FontWeight.w600,
  //                                     letterSpacing: 0.5,
  //                                     color: primaryColor)),
  //                             Text(itemModel.price.toStringAsFixed(2),
  //                                 style: TextStyle(
  //                                     fontSize: 22,
  //                                     fontWeight: FontWeight.w600,
  //                                     letterSpacing: 0.5,
  //                                     color: textDarkColor)),
  //                           ],
  //                         ),
  //                         Text("$CURRENCY${itemModel.price.toStringAsFixed(2)}",
  //                             style: TextStyle(
  //                                 fontSize: 14,
  //                                 fontWeight: FontWeight.w600,
  //                                 letterSpacing: 0.5,
  //                                 color: textMidColor,
  //                                 decoration: TextDecoration.lineThrough)),
  //                       ],
  //                     ),
  //                     Expanded(
  //                       child: SizedBox(),
  //                     ),
  //                     SizedBox(
  //                       height: 34,
  //                       child: ElevatedButton(
  //                           style: ButtonStyle(
  //                               padding: MaterialStateProperty.all(
  //                                   EdgeInsets.symmetric(horizontal: 30)),
  //                               shape: MaterialStateProperty.all(
  //                                   RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(17),
  //                               )),
  //                               backgroundColor:
  //                                   MaterialStateProperty.all(primaryColor),
  //                               textStyle: MaterialStateProperty.all(
  //                                   TextStyle(color: Colors.white))),
  //                           child: Text('ADD',
  //                               style: TextStyle(
  //                                   fontSize: 14,
  //                                   fontWeight: FontWeight.w600,
  //                                   color: Colors.white)),
  //                           onPressed: () {
  //                             Navigator.pushNamed(context, "/item_detail",
  //                                 arguments: itemModel);
  //                           }),
  //                     )
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _gridMenuItem(ItemModel itemModel) {
    return Container(
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)
        ],
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                    child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
                  child: Image.asset(itemModel.image, fit: BoxFit.fitHeight),
                )),
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Container(
                    width: 90,
                    height: 30,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3), blurRadius: 5)
                      ],
                      color: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/icon_alarm_clock.png",
                            width: 12, height: 12),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(itemModel.time,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: textDarkColor)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(itemModel.title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        color: textDarkColor)),
                Text(itemModel.description,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: textLightColor)),
                SizedBox(height: 5),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/images/icon_fire.png",
                          width: 18, height: 18),
                      SizedBox(width: 5),
                      Text(
                          "${itemModel.calories} ${AppLocalizations.of(context)!.translate('calories')}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFB7754))),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/icon_star.png",
                        width: 18, height: 18),
                    SizedBox(width: 8),
                    Expanded(
                        child: Text("${itemModel.reviews.toString()} (24)",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textDarkColor))),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(CURRENCY,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                    color: primaryColor)),
                            Text(itemModel.price.toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                    color: textDarkColor)),
                          ],
                        ),
                        Text("$CURRENCY${itemModel.price.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                                color: textMidColor,
                                decoration: TextDecoration.lineThrough)),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    SizedBox(
                      height: 34,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(horizontal: 30)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(color: Colors.white))),
                          child: Text('ADD',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: SizedBox(
                                          width: 400,
                                          child: ItemDetail(itemModel)),
                                    ));
                              },
                            );
                          }),
                    )
                  ],
                ),
                SizedBox(height: 5),
              ],
            ),
          )
        ],
      ),
    );
  }
}
