import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/pages/auth/auth_wrapper.dart';
import 'package:food_app/pages/auth/auth_wrapper_jwt.dart';
import 'package:food_app/pages/cart/cart.dart';
import 'package:food_app/pages/location/location.dart';
import 'package:food_app/pages/notifications/notification_init.dart';
import 'package:food_app/pages/order/order.dart';
import 'package:food_app/pages/order/order_list.dart';
import 'package:food_app/pages/order/order_list_view.dart';
import 'package:food_app/pages/settings/changelanguage.dart';
import 'package:food_app/pages/auth/changepassword.dart';
import 'package:food_app/pages/auth/forgot.dart';
import 'package:food_app/pages/home/home.dart';
import 'package:food_app/pages/cart/item_detail.dart';
import 'package:food_app/pages/auth/login.dart';
import 'package:food_app/pages/store/store_view.dart';
import 'package:food_app/pages/user/my_account.dart';
import 'package:food_app/pages/location/my_address.dart';
import 'package:food_app/pages/user/notifications.dart';
import 'package:food_app/pages/order/order_tracking1.dart';
import 'package:food_app/pages/order/order_tracking2.dart';
import 'package:food_app/pages/cart/select_address.dart';
import 'package:food_app/pages/settings/select_language.dart';
import 'package:food_app/pages/cart/select_payment_method.dart';
import 'package:food_app/pages/settings/select_theme.dart';
import 'package:food_app/pages/auth/signup.dart';
import 'package:food_app/pages/cart/view_items.dart';
import 'package:food_app/pages/loading/walk_through.dart';
import 'package:food_app/pages/user/shipper_account.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/providers/auth_service.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/providers/notification_provider.dart';
import 'package:provider/provider.dart';
import 'models/store_model.dart';
import 'providers/app_localizations.dart';
import 'configs/colors.dart';
import 'configs/configs.dart';
import 'models/models.dart';

void main() async {
  await dotenv.load(fileName: ".env", mergeWith: {
    'TEST_VAR': '5',
  });
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();

  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  AppLanguage _appLanguage = AppLanguage();
  // AuthService _authService = AuthService();
  CartProvider _cartProvider = CartProvider();
  AuthProvider _authProvider = AuthProvider();
  NotificationProvider _notificationProvider = NotificationProvider();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AppLanguage>(
              create: (context) => _appLanguage),
          // ChangeNotifierProvider<AuthService>(
          //     create: (context) => _authService),
          ChangeNotifierProvider(create: (context) => _authProvider),
          ChangeNotifierProvider(create: (context) => _cartProvider),
          ChangeNotifierProvider(create: (context) => _notificationProvider)
        ],
        child: Consumer<AppLanguage>(builder: (context, model, child) {
          return NotificationInit(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: model.appLocale,
              supportedLocales: _appLanguage.supportedLanguages(),
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              title: APP_NAME,
              theme: ThemeData(
                  primarySwatch: MaterialColor(0xFFD51965, materialColorSet),
                  splashColor: Color(0x44D51965),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  fontFamily: "Opensans",
                  pageTransitionsTheme: PageTransitionsTheme(builders: {
                    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  })),
              initialRoute: '/',
              onGenerateRoute: (settings) {
                var routes = <String, WidgetBuilder>{
                  '/': (context) => WalkThrough(),
                  '/select_theme': (context) => SelectTheme(),
                  '/select_language': (context) => SelectLanguage(),
                  '/home': (context) => AuthWrapperJwt(),
                  '/shipper_account': (context) => ShipperProfile(),
                  '/location': (context) => Location(),
                  '/store': (context) =>
                      StoreView(settings.arguments as StoreModel),
                  '/login': (context) => Login(),
                  '/signup': (context) => SignUp(),
                  '/forgot_password': (context) => ForgotPassword(),
                  '/view_items': (context) =>
                      ViewItems(settings.arguments as Map<dynamic, dynamic>),
                  '/item_detail': (context) =>
                      ItemDetail(settings.arguments as ItemModel),
                  '/cart': (context) => Cart(),
                  '/order': (conext) => Order(orderId: settings.arguments),
                  '/orderList': (conext) => OrderListView(),
                  '/select_address': (context) => SelectAddress(),
                  '/payment_method': (context) => PaymentMethod(),
                  '/my_address': (context) => MyAddress(),
                  '/my_account': (context) => MyAccount(),
                  '/change_language': (context) => ChangeLanguage(),
                  '/change_password': (context) => ChangePassword(),
                  '/notifications': (context) => Notifications(),
                  '/order_tracking1': (context) => OrderTracking1(),
                  '/order_tracking2': (context) => OrderTracking2(),
                };
                WidgetBuilder? builder = routes[settings.name!];
                return MaterialPageRoute(
                    builder: (context) => builder!(context),
                    settings: RouteSettings(name: settings.name));
              },
            ),
          );
        }));
  }
}
