import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route platformPageRoute(Widget screen, RouteSettings settings) {
  return Platform.isAndroid
      ? MaterialPageRoute(builder: (_) => screen, settings: settings)
      : CupertinoPageRoute(builder: (_) => screen, settings: settings);
}
