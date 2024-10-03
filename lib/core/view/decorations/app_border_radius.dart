import 'package:flutter/material.dart';
import 'package:video_player/core/extensions/num_extensions.dart';

class AppBorderRadius {
  static BorderRadius all(double value) => BorderRadius.circular(value.r);

  static BorderRadius top(double value) => BorderRadius.vertical(top: Radius.circular(value.r));

  static BorderRadius bottom(double value) => BorderRadius.vertical(bottom: Radius.circular(value.r));

  static BorderRadiusDirectional only({
    double topStart = 0,
    double topEnd = 0,
    double bottomEnd = 0,
    double bottomStart = 0,
  }) =>
      BorderRadiusDirectional.only(
        topStart: Radius.circular(topStart.r),
        topEnd: Radius.circular(topEnd.r),
        bottomEnd: Radius.circular(bottomEnd.r),
        bottomStart: Radius.circular(bottomStart.r),
      );
}
