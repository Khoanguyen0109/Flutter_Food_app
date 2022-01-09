import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  String _location = '';

  String get getLocation {
    return _location;
  }

  void updateLocation(String value) {
    _location = value;
    notifyListeners();
  }

  void removeLocation() {
    _location = '';
    notifyListeners();
  }
}
