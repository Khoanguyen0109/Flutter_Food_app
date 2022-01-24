import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_app/providers/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/tabs/favorite_tab.dart';
import 'package:food_app/tabs/home_tab.dart';
import 'package:food_app/tabs/offer_tab.dart';
import 'package:food_app/tabs/order_tab.dart';
import 'package:food_app/tabs/profile_tab.dart';
import 'package:food_app/widgets/build_bage.dart';
import 'package:food_app/widgets/offer_dialog.dart';
import 'package:food_app/widgets/resolution_not_supported.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController? _pageController;
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    // Timer(Duration(seconds: 2), () {
    //   showOfferDialog(context, "assets/images/temp_offer1.jpg");
    // });
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);
    int totalItem = Provider.of<CartProvider>(context).totalItem;
    return _buildBody(deviceType, totalItem);
  }

  Widget _buildBody(DeviceType deviceType, int totalItem) {
    if (deviceType == DeviceType.WEB) {
      return Scaffold(
        extendBody: true,
        backgroundColor: backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          actions: [
            _buildHeaderTab(0, "nav_home"),
            _buildHeaderTab(1, "nav_offers"),
            _buildHeaderTab(2, "nav_cart"),
            _buildHeaderTab(3, "nav_wishlist"),
            _buildHeaderTab(4, "nav_account"),
          ],
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedPage = index);
          },
          children: [
            HomeTab(),
            OfferTab(),
            SizedBox(),
            FavoriteTab(),
            ProfileTab()
          ],
        ),
      );
    } else if (deviceType == DeviceType.TABLET ||
        deviceType == DeviceType.MOBILE) {
      return Scaffold(
        extendBody: true,
        backgroundColor: backgroundColor,
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedPage = index);
          },
          children: [
            HomeTab(),
            // OfferTab(),
            OrderTab(),
            SizedBox(),
            OfferTab(),

            // FavoriteTab(),
            ProfileTab()
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          width: 70,
          height: 70,
          child: Stack(
            children: [
              Positioned.fill(
                child: FloatingActionButton(
                  heroTag: "cart_btn",
                  onPressed: () {
                    if (totalItem > 0) {
                      Navigator.pushNamed(context, "/cart");
                    }
                  },
                  backgroundColor: primaryColor,
                  child: Image.asset("assets/images/nav_cart.png",
                      width: 24, height: 24, color: Colors.white),
                  elevation: 12,
                ),
              ),
              BuildBage(count: Provider.of<CartProvider>(context).totalItem)
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          elevation: 12,
          color: Colors.white,
          notchMargin: 12,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              _buildTab(0, "nav_home"),
              _buildTab(1, "nav_offers"),
              // _buildTab(1, "nav_orders"),
              BottomNavigationBarItem(icon: SizedBox(), label: ''),
              _buildTab(3, "nav_wishlist"),
              _buildTab(4, "nav_account"),
            ],
            currentIndex: _selectedPage,
            backgroundColor: Colors.white,
            unselectedItemColor: textLightColor,
            selectedItemColor: primaryColor,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            onTap: _onItemTapped,
          ),
        ),
      );
    } else
      return screenSizeNotSupported(context);
  }

  Widget _buildHeaderTab(int index, String title) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        padding:
            MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 25)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        )),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/images/$title.png",
              width: 18,
              height: 18,
              color: (_selectedPage == index) ? primaryColor : textMidColor),
          SizedBox(width: 8),
          Text(AppLocalizations.of(context)!.translate(title)!,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color:
                      (_selectedPage == index) ? primaryColor : textMidColor)),
        ],
      ),
      onPressed: () => _onItemTapped(index),
    );
  }

  BottomNavigationBarItem _buildTab(int index, String title) {
    return BottomNavigationBarItem(
        icon: Center(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Image.asset("assets/images/$title.png",
              width: 22,
              height: 22,
              color: (_selectedPage == index) ? primaryColor : textLightColor),
        )),
        label: AppLocalizations.of(context)!.translate(title));
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.pushNamed(context, "/cart");
    } else {
      _selectedPage = index;
      _pageController!.animateToPage(index,
          duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }
}
