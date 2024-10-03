import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/core/extensions/num_extensions.dart';

import '../resources/resources.dart';

class Alerts {
  static void showToast(
    String message, [
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity toastGravity = ToastGravity.BOTTOM,
  ]) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: toastGravity,
      timeInSecForIosWeb: 3,
      fontSize: FontSize.s14.sp,
    );
  }
}
