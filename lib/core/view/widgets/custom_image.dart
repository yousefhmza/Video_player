import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/core/extensions/num_extensions.dart';

import '../../resources/resources.dart';
import '../views.dart';

enum ImageType { svg, svgNetwork, png, network, file, unknown }

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (isEmpty || startsWith('http') || startsWith('https')) {
      return ImageType.network;
    } else if ((startsWith('http') || startsWith('https')) && endsWith('.svg')) {
      return ImageType.svgNetwork;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('file://') || startsWith('/data/user')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

class CustomImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  final Color? color;
  final AlignmentDirectional alignment;

  const CustomImage({
    required this.image,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius = AppSize.s0,
    this.color,
    this.alignment = AlignmentDirectional.center,
    super.key,
  });

  Widget _buildImageView() {
    switch (image.imageType) {
      case ImageType.svg:
        return SvgPicture.asset(
          image,
          height: height?.h,
          width: width?.w,
          fit: fit,
          alignment: alignment,
          colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        );
      case ImageType.svgNetwork:
        return SvgPicture.network(
          image,
          height: height?.h,
          width: width?.w,
          fit: fit,
          alignment: alignment,
          colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        );
      case ImageType.file:
        return Image.file(
          File(image),
          height: height?.h,
          width: width?.w,
          fit: fit,
          alignment: alignment,
          color: color,
        );
      case ImageType.network:
        return FadeInImage.assetNetwork(
          image: image,
          height: height?.h,
          width: width?.w,
          placeholder: AppImages.placeholder,
          fit: fit,
          alignment: alignment,
          placeholderFit: BoxFit.cover,
          imageErrorBuilder: (_, __, ___) => Image.asset(
            AppImages.placeholder,
            fit: fit,
            height: height?.h,
            width: width?.w,
          ),
        );
      case ImageType.png:
      default:
        return Image.asset(
          image,
          height: height?.h,
          width: width?.w,
          fit: fit,
          alignment: alignment,
          color: color,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppBorderRadius.all(borderRadius),
      child: _buildImageView(),
    );
  }
}
