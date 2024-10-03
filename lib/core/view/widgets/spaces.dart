import 'package:flutter/material.dart';
import 'package:video_player/core/extensions/num_extensions.dart';

class VerticalSpace extends StatelessWidget {
  final double height;
  final bool isSliver;

  const VerticalSpace(this.height, {super.key})
      : isSliver = false;

  const VerticalSpace.sliver(this.height, {super.key})
      : isSliver = true;

  @override
  Widget build(BuildContext context) {
    return isSliver ? SliverToBoxAdapter(child: SizedBox(height: height.h)) : SizedBox(height: height.h);
  }
}

class HorizontalSpace extends StatelessWidget {
  final double width;
  final bool isSliver;

  const HorizontalSpace(this.width, {Key? key})
      : isSliver = false,
        super(key: key);

  const HorizontalSpace.sliver(this.width, {Key? key})
      : isSliver = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return isSliver ? SliverToBoxAdapter(child: SizedBox(width: width.w)) : SizedBox(width: width.w);
  }
}
