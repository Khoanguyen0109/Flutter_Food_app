import 'package:flutter/material.dart';
import 'package:food_app/configs/GridFixedHeightDelegate.dart';
import 'package:food_app/providers/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/pages/cart/item_detail.dart';
import 'package:food_app/widgets/order_row.dart';
import 'package:food_app/widgets/resolution_not_supported.dart';

class OrderTab extends StatefulWidget {
  @override
  _OrderTabState createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab> {
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
          id: 1,
          name: 'Meat Ball Pasta',
          description: 'Spicy Meat Ball Pasta',
          image: 'assets/images/temp_item1.png',
          reviews: 25,
          price: 3.5,
          status: 1,
          storeId: 1,
          choicesList: _choiceList),
      ItemModel(
          id: 2,
          name: 'Meat Ball Pasta',
          description: 'Spicy Meat Ball Pasta',
          image: 'assets/images/temp_item1.png',
          reviews: 25,
          price: 3.5,
          status: 1,
          storeId: 1,
          choicesList: _choiceList),
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
            children: [],
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
              OrderRow(itemModel: _offersArray[0]),
              OrderRow(itemModel: _offersArray[1]),
            ],
          ),
        ),
      );
    } else
      return screenSizeNotSupported(context);
  }
}
