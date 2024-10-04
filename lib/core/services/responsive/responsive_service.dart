import 'package:flutter/material.dart';
import 'package:video_player/core/extensions/num_extensions.dart';

import 'device_dimensions_type.dart';

class Responsive {
  Responsive._privateConstructor();

  static final Responsive instance = Responsive._privateConstructor();

  DeviceDimensionsType? deviceDimensionsType;

  double deviceWidth(BuildContext context) => MediaQuery.sizeOf(context).width;

  double deviceHeight(BuildContext context) => MediaQuery.sizeOf(context).height;
  final int miniPhoneMinWidth = 320;
  final int miniPhoneMaxWidth = 360;
  final int phoneMinWidth = 360;
  final int phoneMaxWidth = 540;
  final int tabletMinWidth = 540;
  final int tabletMaxWidth = 1024;
  final int computerMinWidth = 1024;

  void setDeviceDimensionsType(BuildContext context) {
    if (deviceWidth(context).isBetweenExclusive(miniPhoneMinWidth, miniPhoneMaxWidth)) {
      deviceDimensionsType = DeviceDimensionsType.miniPhone;
    } else if (deviceWidth(context).isBetweenExclusive(phoneMinWidth, phoneMaxWidth)) {
      deviceDimensionsType = DeviceDimensionsType.phone;
    } else if (deviceWidth(context).isBetweenExclusive(tabletMinWidth, tabletMaxWidth)) {
      deviceDimensionsType = DeviceDimensionsType.tablet;
    } else {
      deviceDimensionsType = DeviceDimensionsType.computer;
    }
  }

  num get textScaleFactor => textScaleFactors[deviceDimensionsType]!;

  num get widthScaleFactor => widthScaleFactors[deviceDimensionsType]!;

  num get heightScaleFactor => heightScaleFactors[deviceDimensionsType]!;

  num get radiusScaleFactor => radiusScaleFactors[deviceDimensionsType]!;

  Map<DeviceDimensionsType?, num> textScaleFactors = {
    DeviceDimensionsType.miniPhone: 0.75,
    DeviceDimensionsType.phone: 1,
    DeviceDimensionsType.tablet: 1.25,
    DeviceDimensionsType.computer: 2.0,
    null: 1,
  };
  Map<DeviceDimensionsType?, num> widthScaleFactors = {
    DeviceDimensionsType.miniPhone: 0.75,
    DeviceDimensionsType.phone: 1,
    DeviceDimensionsType.tablet: 1.25,
    DeviceDimensionsType.computer: 2.0,
    null: 1,
  };
  Map<DeviceDimensionsType?, num> heightScaleFactors = {
    DeviceDimensionsType.miniPhone: 0.75,
    DeviceDimensionsType.phone: 1,
    DeviceDimensionsType.tablet: 1.25,
    DeviceDimensionsType.computer: 2.0,
    null: 1,
  };
  Map<DeviceDimensionsType?, num> radiusScaleFactors = {
    DeviceDimensionsType.miniPhone: 0.75,
    DeviceDimensionsType.phone: 1,
    DeviceDimensionsType.tablet: 1.25,
    DeviceDimensionsType.computer: 2.0,
    null: 1,
  };
}
