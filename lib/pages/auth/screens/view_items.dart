import 'package:flutter/material.dart';
import 'package:food_app/configs/GridFixedHeightDelegate.dart';
import 'package:food_app/services/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/pages/cart/item_detail.dart';
import 'package:food_app/widgets/counter_button.dart';
import 'package:food_app/widgets/dotted_line.dart';
import 'package:food_app/widgets/resolution_not_supported.dart';

class ViewItems extends StatefulWidget {
  final List<CategoryModel>? categoryList;
  ViewItems(this.categoryList);

  @override
  _ViewItemsState createState() => _ViewItemsState();
}

class _ViewItemsState extends State<ViewItems> {
  ScrollController _scrollController = new ScrollController();
  ScrollController _cartScrollController = new ScrollController();

  List<CartModel> cartList = [
    CartModel(1, 'Meat Ball Pasta', 'Spicy Meat Ball Pasta',
        'assets/images/temp_item1.png', 175.00),
    CartModel(2, 'Steak', 'Special Beef Steak', 'assets/images/temp_item2.png',
        190.00),
  ];

  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);

    int gridCount = 0;
    if (deviceType == DeviceType.WEB) {
      final deviceSize = MyClass.getWebSize(MediaQuery.of(context).size);
      gridCount = (deviceSize == DeviceSize.XL) ? 3 : 2;
    }

    return DefaultTabController(
      length: widget.categoryList!.length,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            Container(
                padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1), blurRadius: 20)
                    ],
                    borderRadius: BorderRadiusDirectional.only(
                        bottomStart: Radius.circular(CONTAINER_RADIUS),
                        bottomEnd: Radius.circular(CONTAINER_RADIUS)),
                    color: Colors.white),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: SafeArea(
                  left: false,
                  right: false,
                  bottom: false,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10)
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero),
                                    elevation: MaterialStateProperty.all(0),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    )),
                                  ),
                                  child: Icon(Icons.navigate_before,
                                      color: Colors.black),
                                  onPressed: () => Navigator.pop(context)),
                            ),
                            Expanded(
                              child: Text(
                                  AppLocalizations.of(context)!
                                      .translate('menu')!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: textDarkColor)),
                            ),
                            SizedBox(width: 35, height: 35)
                          ],
                        ),
                      ),
                      TabBar(
                          isScrollable: true,
                          indicatorColor: primaryColor,
                          labelColor: primaryColor,
                          labelStyle: TextStyle(fontWeight: FontWeight.w600),
                          unselectedLabelColor: textDarkColor,
                          unselectedLabelStyle:
                              TextStyle(fontWeight: FontWeight.w400),
                          tabs: List<Widget>.generate(
                              widget.categoryList!.length, (int index) {
                            return Tab(text: widget.categoryList![index].title);
                          })),
                    ],
                  ),
                )),
            SizedBox(height: 3),
            Expanded(
              child: TabBarView(
                children: List<Widget>.generate(widget.categoryList!.length,
                    (int index) {
                  final itemList = widget.categoryList![index].itemsList;
                  _scrollController = new ScrollController();
                  _cartScrollController = new ScrollController();

                  if (deviceType == DeviceType.WEB) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Scrollbar(
                            controller: _scrollController,
                            isAlwaysShown: (deviceType == DeviceType.MOBILE)
                                ? false
                                : true,
                            child: GridView.builder(
                              controller: _scrollController,
                              physics: BouncingScrollPhysics(),
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 10, 20, 30),
                              itemCount: itemList!.length,
                              gridDelegate: GridFixedHeightDelegate(
                                crossAxisCount: gridCount,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                height: 300,
                              ),
                              itemBuilder: (context, pos) {
                                return _gridMenuItem(itemList[pos]);
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: 250,
                          margin: const EdgeInsetsDirectional.fromSTEB(
                              0, 15, 15, 15),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 10)
                            ],
                            borderRadius: BorderRadius.circular(BORDER_RADIUS),
                            color: Colors.white,
                          ),
                          child: Scrollbar(
                            controller: _cartScrollController,
                            isAlwaysShown: (deviceType == DeviceType.MOBILE)
                                ? false
                                : true,
                            child: ListView(
                              controller: _cartScrollController,
                              physics: BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(15),
                              children: [
                                menuItem(cartList[0]),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Divider(height: 1, color: lineColor),
                                ),
                                menuItem(cartList[1]),
                                checkoutItem()
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  } else if (deviceType == DeviceType.TABLET ||
                      deviceType == DeviceType.MOBILE) {
                    return Scrollbar(
                      controller: _scrollController,
                      isAlwaysShown:
                          (deviceType == DeviceType.MOBILE) ? false : true,
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: BouncingScrollPhysics(),
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20, 10, 20, 30),
                        itemCount: itemList!.length,
                        itemBuilder: (context, pos) {
                          return _menuItem(itemList[pos]);
                        },
                      ),
                    );
                  } else
                    return screenSizeNotSupported(context);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(ItemModel itemModel) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20)
        ],
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 115,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                      width: 90,
                      height: 30,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 5)
                        ],
                        color: Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/icon_alarm_clock.png",
                              width: 15, height: 15),
                          SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 15),
                    child: Image.asset(itemModel.image,
                        width: 100, height: 100, fit: BoxFit.fitHeight),
                  ),
                ]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(itemModel.name,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                          color: textDarkColor)),
                  Text(itemModel.description,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: textLightColor)),
                  SizedBox(height: 5),
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
                                child: Text(itemModel.reviews.toString(),
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: textDarkColor))),
                          ],
                        ),
                      ),
                      // Expanded(
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Image.asset("assets/images/icon_fire.png",
                      //           width: 18, height: 18),
                      //       SizedBox(width: 8),
                      //       Expanded(
                      //         child: Text(
                      //             "${itemModel.calories} ${AppLocalizations.of(context)!.translate('calories')}",
                      //             style: TextStyle(
                      //                 fontSize: 13,
                      //                 fontWeight: FontWeight.w600,
                      //                 color: textDarkColor)),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
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
                              Navigator.pushNamed(context, "/item_detail",
                                  arguments: itemModel);
                            }),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

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
                // Align(
                //   alignment: AlignmentDirectional.topEnd,
                //   child: Container(
                //     width: 90,
                //     height: 30,
                //     padding: const EdgeInsets.all(5),
                //     decoration: BoxDecoration(
                //       boxShadow: [
                //         BoxShadow(
                //             color: Colors.black.withOpacity(0.3), blurRadius: 5)
                //       ],
                //       color: Colors.white,
                //     ),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Image.asset("assets/images/icon_alarm_clock.png",
                //             width: 12, height: 12),
                //         SizedBox(width: 5),
                //         Expanded(
                //           child: Text(itemModel.time,
                //               style: TextStyle(
                //                   fontSize: 11,
                //                   fontWeight: FontWeight.w600,
                //                   color: textDarkColor)),
                //         )
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(itemModel.name,
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
                // Center(
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       Image.asset("assets/images/icon_fire.png",
                //           width: 18, height: 18),
                //       SizedBox(width: 5),
                //       Text(
                //           "${itemModel.calories} ${AppLocalizations.of(context)!.translate('calories')}",
                //           maxLines: 1,
                //           overflow: TextOverflow.ellipsis,
                //           style: TextStyle(
                //               fontSize: 13,
                //               fontWeight: FontWeight.w600,
                //               color: Color(0xFFFB7754))),
                //     ],
                //   ),
                // ),
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

  Widget menuItem(CartModel cartModel) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Image.asset(cartModel.image,
              width: 40, height: 40, fit: BoxFit.fitHeight),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(cartModel.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        color: textDarkColor)),
                SizedBox(height: 3),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(CURRENCY,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            color: primaryColor)),
                    Text(cartModel.price.toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            color: textDarkColor)),
                    Expanded(
                      child: SizedBox(),
                    ),
                    SizedBox(
                        width: 80,
                        height: 30,
                        child: CounterButton(minValue: 0, currentValue: 1))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget checkoutItem() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: DottedLine(dashWidth: 5, color: lineColor),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.translate('sub_total')!,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      color: textMidColor)),
              Text('${CURRENCY}90',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      color: textMidColor)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$TAX_LABEL ($TAX_PERCENTAGE%)",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      color: textMidColor)),
              Text('${CURRENCY}17',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      color: textMidColor)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.translate('delivery_cost')!,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      color: textMidColor)),
              Text(AppLocalizations.of(context)!.translate('free')!,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      color: textMidColor)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: DottedLine(dashWidth: 5, color: lineColor),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.translate('grand_total')!,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: textDarkColor)),
              Text('${CURRENCY}107',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: textDarkColor)),
            ],
          ),
          SizedBox(height: 30),
          ElevatedButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 20)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(BORDER_RADIUS),
                )),
                elevation: MaterialStateProperty.all(12),
                backgroundColor: MaterialStateProperty.all(primaryColor),
                textStyle:
                    MaterialStateProperty.all(TextStyle(color: Colors.white))),
            child: Text(AppLocalizations.of(context)!.translate('btn_cart')!,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1)),
            onPressed: () {
              Navigator.pushNamed(context, "/cart");
            },
          ),
        ],
      ),
    );
  }
}
