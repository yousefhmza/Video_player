import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_platform_widget.dart';
import '../../../resources/resources.dart';

class LoadingSpinner extends BasePlatformWidget<Widget, Widget> {
  final bool hasSmallRadius;
  final double? verticalSize;
  final double _radius;
  final double _strokeWidth;
  final Color? color;
  final EdgeInsetsGeometry? margin;

  const LoadingSpinner({this.hasSmallRadius = false, this.color, this.verticalSize, this.margin, super.key})
      : _radius = hasSmallRadius ? AppSize.s12 : AppSize.s24,
        _strokeWidth = hasSmallRadius ? AppSize.s2 : AppSize.s3;

  @override
  Widget createCupertinoWidget(BuildContext context) {
    return Container(
      height: verticalSize,
      margin: margin,
      child: Center(child: CupertinoActivityIndicator(radius: AppSize.s12, color: color)),
    );
  }

  @override
  Widget createMaterialWidget(BuildContext context) {
    return SizedBox(
      height: verticalSize,
      child: Center(
        child: Container(
          height: _radius,
          width: _radius,
          margin: margin,
          child: CircularProgressIndicator(strokeWidth: _strokeWidth, color: color ?? AppColors.primary),
        ),
      ),
    );
  }
}
