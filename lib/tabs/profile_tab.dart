import 'package:flutter/material.dart';
import 'package:food_app/providers/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/pages/settings/changelanguage.dart';
import 'package:food_app/pages/auth/changepassword.dart';
import 'package:food_app/pages/user/my_account.dart';
import 'package:food_app/pages/location/my_address.dart';
import 'package:food_app/pages/user/notifications.dart';
import 'package:food_app/pages/order/order_tracking1.dart';
import 'package:food_app/pages/order/order_tracking2.dart';
import 'package:food_app/providers/auth_service.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);
    final authService = Provider.of<AuthService>(context);

    void onSignout() async {
      await authService.signOut();
      Navigator.pushReplacementNamed(context, 'login');
    }

    return Stack(
      children: [
        Image.asset("assets/images/image_profile_cover.jpg",
            fit: BoxFit.cover, width: double.infinity, height: 320),
        Container(color: Colors.black.withOpacity(0.5), height: 320),
        SafeArea(
          child: Scrollbar(
            isAlwaysShown: (deviceType == DeviceType.MOBILE) ? false : true,
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: (deviceType == DeviceType.WEB)
                          ? WEB_FIXED_WIDTH
                          : 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/images/image_user_default.png'),
                              maxRadius: 45,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('Sohail Asghar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  color: Colors.white)),
                          SizedBox(height: 10),
                          Text('Nothing brings people together like\nGood Food',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 12)
                            ], borderRadius: BorderRadius.circular(12)),
                            child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 0,
                                child: Column(
                                  children: [
                                    profileItem(
                                        Icons.location_on,
                                        AppLocalizations.of(context)!
                                            .translate('my_address')!,
                                        deviceType,
                                        action: goToMyAddress),
                                    separator(),
                                    profileItem(
                                        Icons.person,
                                        AppLocalizations.of(context)!
                                            .translate('account')!,
                                        deviceType,
                                        action: goToMyAccount)
                                  ],
                                )),
                          ),
                          SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 12)
                            ], borderRadius: BorderRadius.circular(12)),
                            child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 0,
                                child: Column(
                                  children: [
                                    profileItem(
                                        Icons.history,
                                        AppLocalizations.of(context)!.translate(
                                            'order_tracking_screen1')!,
                                        deviceType,
                                        action: goToOrderTracking1),
                                    separator(),
                                    profileItem(
                                        Icons.history,
                                        AppLocalizations.of(context)!.translate(
                                            'order_tracking_screen2')!,
                                        deviceType,
                                        action: goToOrderTracking2),
                                    separator(),
                                    profileItem(
                                        Icons.notifications,
                                        AppLocalizations.of(context)!
                                            .translate('notifications')!,
                                        deviceType,
                                        action: goToNotifications),
                                    separator(),
                                    profileItem(
                                        Icons.vpn_key,
                                        AppLocalizations.of(context)!
                                            .translate('password')!,
                                        deviceType,
                                        action: goToPassword),
                                    separator(),
                                    profileItem(
                                        Icons.flag,
                                        AppLocalizations.of(context)!
                                            .translate('language')!,
                                        deviceType,
                                        action: goToLanguage)
                                  ],
                                )),
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                              onPressed: onSignout,
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(vertical: 15)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(BORDER_RADIUS),
                                  )),
                                  elevation: MaterialStateProperty.all(12),
                                  backgroundColor:
                                      MaterialStateProperty.all(primaryColor),
                                  textStyle: MaterialStateProperty.all(
                                      TextStyle(color: Colors.white))),
                              child: Text(
                                  AppLocalizations.of(context)!
                                      .translate('btn_signout')!,
                                  style: TextStyle(

                                      // backgroundColor: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1)))
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        )
      ],
    );
  }

  goToMyAddress(DeviceType deviceType) {
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
                child: SizedBox(width: WEB_FIXED_WIDTH, child: MyAddress()),
              ));
        },
      );
    } else
      Navigator.pushNamed(context, "/my_address");
  }

  goToMyAccount(DeviceType deviceType) {
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
                child: SizedBox(width: WEB_FIXED_WIDTH, child: MyAccount()),
              ));
        },
      );
    } else
      Navigator.pushNamed(context, "/my_account");
  }

  goToNotifications(DeviceType deviceType) {
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
                child: SizedBox(width: WEB_FIXED_WIDTH, child: Notifications()),
              ));
        },
      );
    } else
      Navigator.pushNamed(context, "/notifications");
  }

  goToOrderTracking1(DeviceType deviceType) {
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
                child:
                    SizedBox(width: WEB_FIXED_WIDTH, child: OrderTracking1()),
              ));
        },
      );
    } else
      Navigator.pushNamed(context, "/order_tracking1");
  }

  goToOrderTracking2(DeviceType deviceType) {
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
                child:
                    SizedBox(width: WEB_FIXED_WIDTH, child: OrderTracking2()),
              ));
        },
      );
    } else
      Navigator.pushNamed(context, "/order_tracking2");
  }

  goToPassword(DeviceType deviceType) {
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
                child:
                    SizedBox(width: WEB_FIXED_WIDTH, child: ChangePassword()),
              ));
        },
      );
    } else
      Navigator.pushNamed(context, "/change_password");
  }

  goToLanguage(DeviceType deviceType) {
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
                child:
                    SizedBox(width: WEB_FIXED_WIDTH, child: ChangeLanguage()),
              ));
        },
      );
    } else
      Navigator.pushNamed(context, "/change_language");
  }

  Widget profileItem(IconData icon, String title, DeviceType deviceType,
      {Function? action}) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, color: textLightColor, size: 26),
            SizedBox(width: 15),
            Expanded(
                child: Text(title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        color: textDarkColor))),
            SizedBox(width: 15),
            Icon(Icons.navigate_next, color: textLightColor, size: 26),
          ],
        ),
      ),
      onTap: () => action!(deviceType),
    );
  }

  Widget separator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Divider(height: 0.6, thickness: 0.6, color: lineColor),
    );
  }
}
