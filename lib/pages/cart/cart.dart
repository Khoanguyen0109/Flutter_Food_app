import 'package:flutter/material.dart';
import 'package:food_app/models/order_item_models.dart';
import 'package:food_app/providers/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/pages/cart/select_address.dart';
import 'package:food_app/pages/cart/select_payment_method.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/services/order_services.dart';
import 'package:food_app/utils/toast_utls.dart';
import 'package:food_app/widgets/counter_button.dart';
import 'package:food_app/widgets/delivery_note_dialog.dart';
import 'package:food_app/widgets/dotted_line.dart';
import 'package:food_app/widgets/voucher_dialog.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final _locationInputController = TextEditingController();
  String location = '';
  int paymentMethod = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    int totalItem = Provider.of<CartProvider>(context).totalItem;
    if (totalItem == 0) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context);
      });
    }
    super.didChangeDependencies();
  }

  void selectPaymentMethod(int method) {
    setState(() {
      paymentMethod = method;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);
    List<OrderItem> cartList = Provider.of<CartProvider>(context).items;
    int? storeId = Provider.of<CartProvider>(context).storeId;

    double grandTotal = Provider.of<CartProvider>(context).totalPay;
    submitOrder() async {
      final order = await OrderServices.createOrder(storeId, cartList);
      if (order != null) {
        Navigator.pushNamed(context, "/order");

        ToastUtils.toastSucessfull("Order Successfull");
      } else {
        Navigator.pushNamed(context, "/order");

        ToastUtils.toastFailed("Submit order Failed");
      }
    }

    void updateCartItem(ItemModel item, int quantity) {
      Provider.of<CartProvider>(context, listen: false)
          .updateItem(item, quantity);
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        leading: Center(
          child: Container(
            width: 35,
            height: 35,
            margin: const EdgeInsetsDirectional.only(start: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
                ),
                child: Icon(Icons.navigate_before, color: Colors.black),
                onPressed: () => Navigator.pop(context)),
          ),
        ),
        title: Text(AppLocalizations.of(context)!.translate('cart')!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: textDarkColor)),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => goToAddress(deviceType),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                      height: 70,
                      // padding: const EdgeInsets.symmetric(horizontal: 10),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 20)
                        ],
                        borderRadius: BorderRadius.circular(BORDER_RADIUS),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: _locationInputController,
                        decoration: InputDecoration(
                          icon: Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 10,
                            height: 10,
                            child: Icon(
                              Icons.home,
                              color: Colors.black,
                            ),
                          ),
                          hintText: "Enter your shipping address",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
                        ),
                      )
                      // child: Row(
                      //   children: [
                      //     Icon(
                      //       Icons.home,
                      //       color: Colors.black,
                      //     ),
                      //     SizedBox(
                      //       width: 15,
                      //     ),
                      //     Text(
                      //       location != ''
                      //           ? location
                      //           : 'Enter your shipping address',
                      //       style: TextStyle(color: Colors.black),
                      //     ),
                      //   ],
                      // ),
                      ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: (deviceType != DeviceType.WEB) ? 15 : 30),
                  scrollDirection: Axis.vertical,
                  itemCount: cartList.length,
                  itemBuilder: (context, index) {
                    return menuItem(
                        deviceType, cartList[index], updateCartItem);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 10);
                  },
                ),
              ),
              checkoutItem(deviceType, grandTotal, submitOrder)

              // Expanded(
              //   flex: 1,
              //   child: SizedBox(
              //     child: Scrollbar(
              //       isAlwaysShown:
              //           (deviceType == DeviceType.MOBILE) ? false : true,
              //       // child: ListView(
              //       //   physics: BouncingScrollPhysics(),
              //       //   padding: const EdgeInsets.symmetric(
              //       //       horizontal: 20, vertical: 10),

              //       //   children: [
              //       //     menuItem(deviceType, cartList[0]),
              //       //     menuItem(deviceType, cartList[1]),
              //       //     checkoutItem(deviceType)
              //       //   ],
              //       // ),
              //       child: ListView.separated(
              //                 physics: BouncingScrollPhysics(),
              //                 padding: EdgeInsets.symmetric(
              //                     horizontal:
              //                         (deviceType != DeviceType.WEB) ? 15 : 30),
              //                 scrollDirection: Axis.horizontal,
              //                 itemCount: cartList!.length,
              //                 itemBuilder: (context, index) {
              //                   return menuItem(deviceType ,
              //                       cartList![index] );
              //                 },
              //                 separatorBuilder: (context, index) {
              //                   return SizedBox(width: 10);
              //                 },
              //               ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuItem(DeviceType deviceType, OrderItem orderItem, updateCartItem) {
    void update(int quantity) {
      print(quantity);
      updateCartItem(orderItem.item, quantity);
    }

    return Center(
      child: Container(
        width: (deviceType == DeviceType.WEB || deviceType == DeviceType.TABLET)
            ? WEB_FIXED_WIDTH
            : double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(15),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20)
          ],
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Image.asset(orderItem.item.image,
                width: 100, height: 100, fit: BoxFit.fitHeight),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 5),
                  Text(orderItem.item.name,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                          color: textDarkColor)),
                  Text(orderItem.item.description,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: textLightColor)),
                  SizedBox(height: 20),
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
                      Text(orderItem.totalPrice.toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              color: textDarkColor)),
                      Expanded(
                        child: SizedBox(),
                      ),
                      SizedBox(
                          width: 80,
                          height: 30,
                          child: CounterButton(
                            minValue: 0,
                            currentValue: orderItem.quantity,
                            cartUpdate: true,
                            updateCartItem: update,
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget checkoutItem(DeviceType deviceType, double grandTotal, submitOrder) {
    return Center(
      child: Container(
        width: (deviceType == DeviceType.WEB || deviceType == DeviceType.TABLET)
            ? WEB_FIXED_WIDTH
            : double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20)
          ],
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                Text('${CURRENCY} ${grandTotal}',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        color: textDarkColor)),
              ],
            ),
            // SizedBox(height: 20),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   child: Divider(height: 1, color: lineColor),
            // ),
            // InkWell(
            //   onTap: () {
            //     showVoucherDialog(context);
            //   },
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Expanded(
            //         child: Text(
            //             AppLocalizations.of(context)!
            //                 .translate('have_voucher')!,
            //             style: TextStyle(
            //                 fontSize: 15,
            //                 fontWeight: FontWeight.w600,
            //                 letterSpacing: 0.5,
            //                 color: textDarkColor)),
            //       ),
            //       Row(
            //         children: [
            //           Text(
            //               AppLocalizations.of(context)!.translate('btn_apply')!,
            //               style: TextStyle(
            //                   fontSize: 15,
            //                   fontWeight: FontWeight.w600,
            //                   color: primaryColor)),
            //           SizedBox(width: 3),
            //           Icon(Icons.add, color: primaryColor, size: 24)
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   child: Divider(height: 1, color: lineColor),
            // ),
            // InkWell(
            //   onTap: () => goToAddress(deviceType),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Expanded(
            //         child: Text(
            //             AppLocalizations.of(context)!.translate('address')!,
            //             style: TextStyle(
            //                 fontSize: 15,
            //                 fontWeight: FontWeight.w600,
            //                 letterSpacing: 0.5,
            //                 color: textDarkColor)),
            //       ),
            //       Row(
            //         children: [
            //           Text(
            //               AppLocalizations.of(context)!
            //                   .translate('btn_select')!,
            //               style: TextStyle(
            //                   fontSize: 15,
            //                   fontWeight: FontWeight.w600,
            //                   color: primaryColor)),
            //           SizedBox(width: 3),
            //           Icon(Icons.navigate_next, color: primaryColor, size: 24)
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Divider(height: 1, color: lineColor),
            ),
            InkWell(
              onTap: () => goToPaymentMethod(deviceType),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                        AppLocalizations.of(context)!
                            .translate('payment_method')!,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            color: textDarkColor)),
                  ),
                  Row(
                    children: [
                      Text(renderPaymentMethod(paymentMethod),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: primaryColor)),
                      SizedBox(width: 3),
                      Icon(Icons.navigate_next, color: primaryColor, size: 24)
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Divider(height: 1, color: lineColor),
            ),
            // InkWell(
            //   onTap: () => showDeliveryNoteDialog(context),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Expanded(
            //         child: Text(
            //             AppLocalizations.of(context)!
            //                 .translate('delivery_instructions')!,
            //             style: TextStyle(
            //                 fontSize: 15,
            //                 fontWeight: FontWeight.w600,
            //                 letterSpacing: 0.5,
            //                 color: textDarkColor)),
            //       ),
            //       Row(
            //         children: [
            //           Text(
            //               AppLocalizations.of(context)!
            //                   .translate('btn_add_notes')!,
            //               style: TextStyle(
            //                   fontSize: 15,
            //                   fontWeight: FontWeight.w600,
            //                   color: primaryColor)),
            //           SizedBox(width: 3),
            //           Icon(Icons.add, color: primaryColor, size: 24)
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 30),
            ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                      vertical: (deviceType == DeviceType.WEB) ? 20 : 15)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(BORDER_RADIUS),
                  )),
                  elevation: MaterialStateProperty.all(12),
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(color: Colors.white))),
              child: Text(
                  AppLocalizations.of(context)!.translate('btn_check_out')!,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1)),
              onPressed: () {
                submitOrder();
              },
            ),
          ],
        ),
      ),
    );
  }

  goToAddress(DeviceType deviceType) {
    if (deviceType == DeviceType.WEB) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(width: WEB_FIXED_WIDTH, child: SelectAddress()),
              ));
        },
      );
    } else
      Navigator.pushNamed(context, "/select_address");
  }

  goToPaymentMethod(DeviceType deviceType) {
    if (deviceType == DeviceType.WEB) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(width: WEB_FIXED_WIDTH, child: PaymentMethod()),
              ));
        },
      );
    } else {
      // Navigator.pushNamed(context, "/payment_method", arguments: {});
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentMethod(
            paymemtMethod: paymentMethod,
            selectPaymentMethod: selectPaymentMethod,
          ),
        ),
      );
    }
  }

  renderPaymentMethod(int paymentMetho) {
    switch (paymentMetho) {
      case -1:
        return AppLocalizations.of(context)!.translate('btn_select');

      case 1:
        return "Cash";
      case 2:
        return "Credit card";
      default:
    }
  }
}
