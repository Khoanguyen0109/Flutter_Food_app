import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static void toastSucessfull(String message) {
    Fluttertoast.showToast(msg: message, gravity: ToastGravity.TOP);
  }

  static void toastFailed(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red[400],
        timeInSecForIosWeb: 2);
  }
}
