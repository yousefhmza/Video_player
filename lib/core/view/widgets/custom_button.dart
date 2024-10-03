import 'package:flutter/material.dart';

import '../../resources/resources.dart';
import '../views.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? color;
  final Color? textColor;
  final Widget? child;
  final double? height;
  final double? width;
  final double? textHeight;
  final double fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? spinnerColor;
  final bool isOutlined;
  final bool isLoading;

  const CustomButton({
    super.key,
    this.onPressed,
    this.text = "",
    this.color,
    this.textColor,
    this.child,
    this.width,
    this.height,
    this.textHeight,
    this.fontWeight,
    this.padding,
    this.margin,
    this.spinnerColor,
    this.isOutlined = false,
    this.isLoading = false,
    this.fontSize = FontSize.s16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: ShapeDecoration(
            shape: StadiumBorder(
              side: isOutlined ? BorderSide(color: color ?? AppColors.primary) : BorderSide.none,
            ),
            color: onPressed == null ? AppColors.grey500 : color,
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: AppBorderRadius.all(AppSize.s100),
            child: Container(
              padding: height != null
                  ? AppEdgeInsets.symmetric(horizontal: AppPadding.p16)
                  : padding ?? AppEdgeInsets.symmetric(vertical: AppPadding.p12, horizontal: AppPadding.p16),
              child: isLoading
                  ? LoadingSpinner(hasSmallRadius: true, color: spinnerColor ?? AppColors.white)
                  : text.isNotEmpty
                      ? CustomText(
                          text,
                          color: onPressed == null ? AppColors.grey500 : textColor ?? AppColors.white,
                          fontWeight: fontWeight ?? FontWeightManager.bold,
                          fontSize: fontSize,
                          textAlign: TextAlign.center,
                          height: textHeight,
                        )
                      : child,
            ),
          ),
        ),
      ),
    );
  }
}
