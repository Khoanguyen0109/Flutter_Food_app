import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/providers/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/services/store_services.dart';
import 'package:food_app/widgets/resolution_not_supported.dart';
import 'package:provider/provider.dart';

class WalkThrough extends StatefulWidget {
  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {
  int _current = 0;
  List<StoreModel>? _storeArray;

  List<String> sliderArray = [
    "assets/images/temp_discount1.png",
    "assets/images/temp_discount2.png",
    "assets/images/temp_discount3.png",
    "assets/images/temp_discount4.png"
  ];

  void getUser() async {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
        context,
        '/home',
      );
    });
  }

  @override
  void initState() {
    super.initState();
    // User user = Provider.of<AuthProvider>(context).getUser;

    getUser();
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      child:
          Scaffold(backgroundColor: primaryColor, body: _buildBody(deviceType)),
    );
  }

  Widget _buildBody(DeviceType deviceType) {
    if (deviceType == DeviceType.WEB) {
      return SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 1.2,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            reverse: true,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),

                            // autoPlayInterval: Duration(seconds: 1),
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                        items: sliderArray.map((slider) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24),
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(slider,
                                        fit: BoxFit.fitHeight)),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: sliderArray.map((url) {
                          int index = sliderArray.indexOf(url);
                          return Container(
                            width: 30,
                            height: 8,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2)),
                              color: _current == index
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.3),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? Color.fromRGBO(0, 0, 0, 0.9)
                                    : Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                            AppLocalizations.of(context)!
                                .translate('walk_through_title')!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                                color: Colors.white)),
                        SizedBox(height: 15),
                        Text(
                            AppLocalizations.of(context)!
                                .translate('walk_through_desc')!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                                color: Colors.white)),
                        SizedBox(height: 30),
                        Center(
                          child: SizedBox(
                            width: 300,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(vertical: 20)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(BORDER_RADIUS),
                                )),
                                elevation: MaterialStateProperty.all(12),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      AppLocalizations.of(context)!
                                          .translate('btn_skip')!,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1,
                                          color: primaryColor)),
                                  SizedBox(width: 10),
                                  Icon(Icons.navigate_next, color: primaryColor)
                                ],
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, "/login");
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (deviceType == DeviceType.TABLET ||
        deviceType == DeviceType.MOBILE) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio:
                              (deviceType == DeviceType.TABLET) ? 1.8 : 1.2,
                          enlargeCenterPage: true,
                          reverse: false,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          enableInfiniteScroll: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                      items: sliderArray.map((slider) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.asset(slider,
                                      fit: BoxFit.fitHeight)),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Container(
                      padding: const EdgeInsets.all(30),
                      margin: EdgeInsets.only(bottom: 100),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                              AppLocalizations.of(context)!
                                  .translate('walk_through_title')!,
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                  color: Colors.white)),
                          SizedBox(height: 15),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: sliderArray.map((url) {
                    //     int index = sliderArray.indexOf(url);
                    //     return Container(
                    //       width: 30,
                    //       height: 8,
                    //       margin:
                    //           EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.all(Radius.circular(2)),
                    //         color: _current == index
                    //             ? Colors.white
                    //             : Colors.white.withOpacity(0.3),
                    //       ),
                    //       child: Container(
                    //         margin: EdgeInsets.all(4),
                    //         decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           color: _current == index
                    //               ? Color.fromRGBO(0, 0, 0, 0.9)
                    //               : Color.fromRGBO(0, 0, 0, 0.4),
                    //         ),
                    //       ),
                    //     );
                    //   }).toList(),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    } else
      return screenSizeNotSupported(context);
  }
}
