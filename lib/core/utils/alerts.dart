import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/core/extensions/num_extensions.dart';

import '../resources/resources.dart';

class Alerts {
  static Future<void> cancelToast() async => await Fluttertoast.cancel();
  static void showToast(
    String message, {
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity toastGravity = ToastGravity.BOTTOM,
    Color? bgColor,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      backgroundColor: bgColor,
      gravity: toastGravity,
      timeInSecForIosWeb: 3,
      fontSize: FontSize.s14.sp,
    );
  }
}
