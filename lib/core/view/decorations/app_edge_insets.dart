import 'package:flutter/material.dart';
import 'package:video_player/core/extensions/num_extensions.dart';

class AppEdgeInsets {
  static EdgeInsets all(double value) => EdgeInsets.all(value.w);

  static EdgeInsets symmetric({double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(horizontal: horizontal.w, vertical: vertical.h);

  static EdgeInsetsDirectional only({double start = 0, double top = 0, double end = 0, double bottom = 0}) =>
      EdgeInsetsDirectional.only(start: start.w, top: top.h, end: end.w, bottom: bottom.h);
}
