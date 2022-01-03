import 'dart:ui';

import 'package:food_app/configs/configs.dart';

class MyClass {
  static DeviceType getDeviceType(Size screenSize) {
    if (screenSize.width < 520)
      return DeviceType.MOBILE;
    if (screenSize.width < 720)
      return DeviceType.TABLET;
    else
      return DeviceType.WEB;
  }

  static DeviceSize getWebSize(Size screenSize) {
    if (screenSize.width < 1100)
      return DeviceSize.NORMAL;
    else
      return DeviceSize.XL;
  }
}