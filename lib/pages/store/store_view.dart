import 'package:flutter/material.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/services/app_localizations.dart';
import 'package:food_app/services/cart_provider.dart';
import 'package:food_app/widgets/back_button.dart' as BackButton;
import 'package:food_app/widgets/build_bage.dart';
import 'package:food_app/widgets/item_row.dart';
import 'package:provider/provider.dart';

class StoreView extends StatefulWidget {
  final StoreModel storeModel;
  StoreView(this.storeModel);
  @override
  _StoreViewState createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  late List<ItemModel> _offersArray;
  List<SubChoiceModel>? _subChoiceList;
  List<ChoiceModel>? _choiceList;

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
          image: 'assets/images/temp_item2.png',
          reviews: 25,
          price: 3.5,
          status: 1,
          storeId: 2,
          choicesList: _choiceList),
      ItemModel(
          id: 1,
          name: 'Meat Ball Pasta',
          description: 'Spicy Meat Ball Pasta',
          image: 'assets/images/temp_item3.png',
          reviews: 25,
          price: 3.5,
          status: 1,
          storeId: 1,
          choicesList: _choiceList),
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);

    return Scaffold(
        backgroundColor: backgroundColor,
        floatingActionButton: Provider.of<CartProvider>(context).totalItem > 0
            ? SizedBox(
                width: 70,
                height: 70,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: FloatingActionButton(
                        heroTag: "cart_btn",
                        onPressed: () => Navigator.pushNamed(context, "/cart"),
                        backgroundColor: primaryColor,
                        child: Image.asset("assets/images/nav_cart.png",
                            width: 24, height: 24, color: Colors.white),
                        elevation: 12,
                      ),
                    ),
                    BuildBage(
                        count: Provider.of<CartProvider>(context).totalItem)
                  ],
                ),
              )
            : Container(),
        body: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                slivers: <Widget>[
                  // SliverAppBar(
                  //   pinned: true,
                  //   snap: false,
                  //   floating: true,
                  //   expandedHeight: 160.0,
                  //   flexibleSpace: FlexibleSpaceBar(
                  //     title: Container(child: Text('SliverAppBar')),
                  //     background: FlutterLogo(),
                  //   ),
                  // ),
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    snap: false,
                    floating: false,
                    backgroundColor: Colors.black45,
                    // title: Text(
                    //   widget.storeModel.name,
                    //   style: TextStyle(color: Colors.white, fontSize: 30),
                    // ),
                    expandedHeight: 200.0,
                    flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          widget.storeModel.name,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        background: Image.asset("assets/images/temp_item1.png",
                            width: 18, height: 18)),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      width: 50,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Text("Address"),
                              // SizedBox(width: 10,)
                              Text(widget.storeModel.address),
                            ],
                          ),
                          // Text("asdsadss"),
                        ],
                      ),
                    ),
                  ),
                  SliverFixedExtentList(
                    itemExtent: 160.0,
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return ItemRow(itemModel: _offersArray[index]);
                    }, childCount: _offersArray.length),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: BackButton.MyBackButton(),
              )
            ],
          ),
        ));
  }
}
