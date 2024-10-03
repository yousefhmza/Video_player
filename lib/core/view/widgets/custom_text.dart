import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:video_player/core/extensions/num_extensions.dart';

import '../../resources/resources.dart';

class CustomText extends StatelessWidget {
  final bool autoSized;
  final String text;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final double? height;
  final int? maxLines;
  final TextDecoration? decoration;
  final Color? decorationColor;

  const CustomText(
    this.text, {
    this.autoSized = false,
    this.color,
    this.fontSize = FontSize.s14,
    this.fontWeight = FontWeightManager.medium,
    this.textAlign,
    this.height,
    this.maxLines,
    this.decoration,
    this.decorationColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      color: color ?? AppColors.black,
      fontSize: fontSize.sp,
      fontFamily: FontConstants.arabicFontFamily,
      fontWeight: fontWeight,
      height: height?.h,
      decoration: decoration,
      decorationColor: decorationColor,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
    return autoSized
        ? AutoSizeText(
            text,
            textAlign: textAlign,
            overflow: maxLines != null ? TextOverflow.ellipsis : null,
            maxLines: maxLines,
            style: textStyle,
            minFontSize: FontSize.s8.sp,
          )
        : Text(
            text,
            textAlign: textAlign,
            overflow: maxLines != null ? TextOverflow.ellipsis : null,
            maxLines: maxLines,
            style: textStyle,
          );
  }
}
