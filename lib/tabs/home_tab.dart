import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/providers/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/pages/home/filter.dart';
import 'package:food_app/pages/cart/item_detail.dart';
import 'package:food_app/pages/store/horizontal_list.dart';
import 'package:food_app/pages/store/store_row.dart';
import 'package:food_app/services/store_services.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  ScrollController _scrollController = new ScrollController();
  ScrollController _popularScrollController = new ScrollController();
  final searchController = TextEditingController();
  Timer? _debouce;
  String searchText = '';
  bool onSearching = false;
  List<SubChoiceModel>? _subChoiceList;
  List<ChoiceModel>? _choiceList;
  List<ItemModel>? _trendsArray;
  List<StoreModel>? _storeArray;
  List<StoreModel>? _poppularStore;
  bool loading = false;

  List<CategoryModel>? _categoriesArray;

  Future<List<StoreModel>> getStoreList() async {
    List<StoreModel> storeList = [];
    return storeList;
  }

  _onSearchChange() async {
    if (_debouce?.isActive ?? false) _debouce?.cancel();
    _debouce = Timer(const Duration(microseconds: 500), () async {
      if (searchText != searchController.text) {
        dynamic storeList = await getStoreList();
        setState(() {
          _storeArray = storeList;
          searchText = searchController.text;
          onSearching = searchController.text == '' ? false : true;
        });
      }
    });
  }

  Future<dynamic> _fetchStoreList() async {
    final data = await StoreServices.fetchStoreList(null, null);
    // setState(() {
    //   _storeArray = data;
    // });
    return data;
  }

  // Future<dynamic> _fetchPopularStore() async {
  //   final data = await StoreServices.fetchPopularStoreList();
  //   setState(() {
  //     _poppularStore = data;
  //   });
  //   return data;
  // }

  _initData() async {
    setState(() {
      loading = true;
    });
    Future.wait([_fetchStoreList()]).then((List responses) {
      // print(responses);
      setState(() {
        loading = false;
      });
    }).catchError((e) {
      print(e.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    searchController.addListener(_onSearchChange);
    super.initState();
    _initData();
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

    _trendsArray = [
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
    _poppularStore = [
      StoreModel(
          id: '1',
          name: "Papaxot",
          image: 'assets/images/temp_item4.png',
          description: "156 Nguyen thi thap  ",
          address: "156 Nguyen thi thap  ",
          category: 0,
          review: 5.0),
      StoreModel(
          id: '2',
          name: "Papaxot",
          image: 'assets/images/temp_item4.png',
          description: "156 Nguyen thi thap  ",
          address: "156 Nguyen thi thap 156 Nguyen thi thap  ",
          category: 0,
          review: 5.0),
      StoreModel(
          id: '3',
          name: "Papaxot",
          image: 'assets/images/temp_item4.png',
          description: "156 Nguyen thi thap  ",
          address: "156 Nguyen thi thap  ",
          category: 0,
          review: 5.0)
    ];

    _storeArray = [
      StoreModel(
          id: '1',
          name: "Papaxot",
          image: 'assets/images/temp_item4.png',
          description: "156 Nguyen thi thap  ",
          address: "156 Nguyen thi thap  ",
          category: 0,
          review: 5.0),
      StoreModel(
          id: '2',
          name: "Papaxot",
          image: 'assets/images/temp_item4.png',
          description: "156 Nguyen thi thap  ",
          address: "156 Nguyen thi thap 156 Nguyen thi thap  ",
          category: 0,
          review: 5.0),
      StoreModel(
          id: '3',
          name: "Papaxot",
          image: 'assets/images/temp_item4.png',
          description: "156 Nguyen thi thap  ",
          category: 0,
          address: "156 Nguyen thi thap  ",
          review: 5.0)
    ];

    _categoriesArray = [
      CategoryModel(1, 'Rice', 'assets/images/temp_item5.png', _storeArray!),
      CategoryModel(2, 'Noodles', 'assets/images/temp_item6.png', _storeArray!),
      CategoryModel(3, 'Drink', 'assets/images/temp_item4.png', _storeArray!),
      CategoryModel(
          4, 'Fast Food', 'assets/images/temp_item7.png', _storeArray!),
      CategoryModel(5, 'Healthy', 'assets/images/temp_item8.png', _storeArray!),
      CategoryModel(6, 'Snacks', 'assets/images/temp_item9.png', _storeArray!)
    ];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.removeListener(_onSearchChange);
    searchController.dispose();
    _debouce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);

    int gridCount = 0;
    if (deviceType == DeviceType.WEB) {
      final deviceSize = MyClass.getWebSize(MediaQuery.of(context).size);
      gridCount = (deviceSize == DeviceSize.XL) ? 6 : 4;
    } else
      gridCount = 2;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          if (deviceType == DeviceType.WEB) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      AppLocalizations.of(context)!
                          .translate("lets_eat_quality_food")!,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: textDarkColor)),
                  SizedBox(
                    width: 400,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius:
                                  BorderRadius.circular(BORDER_RADIUS),
                              color: backgroundSecondaryColor,
                            ),
                            child: Row(
                              children: [
                                Image.asset("assets/images/icon_search.png",
                                    width: 18,
                                    height: 18,
                                    color: textDarkColor),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    controller: searchController,
                                    decoration: InputDecoration.collapsed(
                                      hintText: AppLocalizations.of(context)!
                                          .translate("search"),
                                      hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                          color: textMidColor),
                                      border: InputBorder.none,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                    ),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: textDarkColor),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white, width: 3),
                                borderRadius:
                                    BorderRadius.circular(BORDER_RADIUS),
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor),
                            ),
                            child: Center(
                              child: Image.asset(
                                  "assets/images/icon_filter.png",
                                  width: 18,
                                  height: 18,
                                  color: Colors.white),
                            ),
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
                                            width: WEB_FIXED_WIDTH,
                                            child: FilterDialog()),
                                      ));
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
          ],
          if (deviceType == DeviceType.TABLET ||
              deviceType == DeviceType.MOBILE) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                      AppLocalizations.of(context)!
                          .translate("lets_eat_quality_food")!,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: textDarkColor)),
                  Expanded(child: SizedBox.shrink()),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/notifications");
                      },
                      child: Icon(Icons.notifications))
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(BORDER_RADIUS),
                        color: backgroundSecondaryColor,
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/images/icon_search.png",
                              width: 18, height: 18, color: textDarkColor),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration.collapsed(
                                hintText: AppLocalizations.of(context)!
                                    .translate("search"),
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                    color: textMidColor),
                                border: InputBorder.none,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: textDarkColor),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white, width: 3),
                          borderRadius: BorderRadius.circular(BORDER_RADIUS),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(primaryColor),
                      ),
                      child: Center(
                        child: Image.asset("assets/images/icon_filter.png",
                            width: 18, height: 18, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute<bool>(
                            builder: (BuildContext context) {
                              return FilterDialog();
                            },
                            fullscreenDialog: true));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
          Flexible(
            child: Scrollbar(
              controller: _scrollController,
              isAlwaysShown: (deviceType == DeviceType.MOBILE) ? false : true,
              child: ListView(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Visibility(
                        visible: !onSearching,
                        child: HorizontalScrollList(
                            title: "Popular",
                            routeName: "/view_items",
                            list: _storeArray as List<dynamic>),
                      ),
                      Visibility(
                        visible: !onSearching,
                        child: HorizontalScrollList(
                            title: "Popular",
                            routeName: "/view_items",
                            list: _storeArray as List<dynamic>),
                      ),
                      SizedBox(height: 20),
                      Visibility(
                        visible: !onSearching,
                        child: Column(
                          children: [
                            Title(deviceType: deviceType, title: "menu"),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  (deviceType != DeviceType.WEB) ? 8 : 25,
                                  8,
                                  (deviceType != DeviceType.WEB) ? 8 : 25,
                                  30),
                              itemCount: _categoriesArray!.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: gridCount,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                return categoryItem(_categoriesArray![index]);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return StoreRow(_storeArray![index]);
                          },
                          scrollDirection: Axis.vertical,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 2);
                          },
                          itemCount: _storeArray!.length),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget popularItem(ItemModel itemModel, DeviceType deviceType) {
    return GestureDetector(
        onTap: () {
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
                      child: SizedBox(
                          width: WEB_FIXED_WIDTH, child: ItemDetail(itemModel)),
                    ));
              },
            );
          } else {
            Navigator.pushNamed(context, "/item_detail", arguments: itemModel);
          }
        },
        child: Container(
          width: (deviceType == DeviceType.WEB) ? 200 : 160,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          padding: const EdgeInsets.all(15),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(BORDER_RADIUS),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(itemModel.image, height: 130, fit: BoxFit.fitHeight),
              SizedBox(height: 5),
              Text(itemModel.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: textDarkColor)),
              SizedBox(height: 5),
              Text(itemModel.description,
                  maxLines: 1,
                  textAlign: TextAlign.center,
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
              //           style: TextStyle(
              //               fontSize: 13,
              //               fontWeight: FontWeight.w600,
              //               color: Color(0xFFFB7754))),
              //     ],
              //   ),
              // ),
              Expanded(child: SizedBox()),
              Center(
                child: Row(
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
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget categoryItem(CategoryModel categoryModel) {
    return GestureDetector(
        onTap: () => Navigator.pushNamed(context, "/view_items",
            arguments: _categoriesArray),
        child: Container(
          width: 160,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(15),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(BORDER_RADIUS),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child:
                      Image.asset(categoryModel.image, fit: BoxFit.fitHeight)),
              SizedBox(height: 5),
              Text(categoryModel.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: textDarkColor)),
            ],
          ),
        ));
  }
}

class Title extends StatelessWidget {
  const Title({Key? key, required this.deviceType, required this.title})
      : super(key: key);

  final DeviceType deviceType;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: (deviceType != DeviceType.WEB) ? 20 : 30),
        child: Text(AppLocalizations.of(context)!.translate(title)!,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: primaryColor)));
  }
}
