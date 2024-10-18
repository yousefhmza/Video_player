import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:video_player/core/utils/debouncer.dart';
import 'package:video_player/core/view/views.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/services/responsive/responsive_service.dart';

class BlackOverlay extends StatefulWidget {
  final bool isVisible;
  final BetterPlayerController videoController;
  final VoidCallback hideControls;

  const BlackOverlay({
    required this.isVisible,
    required this.videoController,
    required this.hideControls,
    super.key,
  });

  @override
  State<BlackOverlay> createState() => _BlackOverlayState();
}

class _BlackOverlayState extends State<BlackOverlay> with SingleTickerProviderStateMixin {
  int leftTapCount = 0;
  int rightTapCount = 0;
  ValueNotifier<int> movedSeconds = ValueNotifier<int>(0);
  final DeBouncer deBouncer = DeBouncer(debouncingDuration: Time.t300ms);
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Time.t300ms);
    animation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> onNextTap() async {
    // Debouncing technique seeking the desired video position after stop tapping on the right or left sides of screen
    rightTapCount++;
    movedSeconds.value = 10 * (rightTapCount - 1);
    if (rightTapCount == 2) animationController.forward();
    deBouncer.debounce(
      callback: () {
        if (rightTapCount > 1) {
          widget.videoController.seekTo(
            widget.videoController.videoPlayerController!.value.position + Duration(seconds: movedSeconds.value),
          );
          Future.delayed(Time.t1s, () async {
            if (leftTapCount != 0 || rightTapCount != 0) return;
            await animationController.reverse();
            movedSeconds.value = 0;
          });
        } else {
          widget.hideControls();
        }
        rightTapCount = 0;
      },
    );
  }

  Future<void> onPreviousTap() async {
    leftTapCount++;
    movedSeconds.value = -1 * 10 * (leftTapCount - 1);
    if (leftTapCount == 2) animationController.forward();
    deBouncer.debounce(
      callback: () {
        if (leftTapCount > 1) {
          widget.videoController.seekTo(
            widget.videoController.videoPlayerController!.value.position - Duration(seconds: movedSeconds.value * -1),
          );
          Future.delayed(Time.t1s, () async {
            if (leftTapCount != 0 || rightTapCount != 0) return;
            await animationController.reverse();
            movedSeconds.value = 0;
          });
        } else {
          widget.hideControls();
        }
        leftTapCount = 0;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isVisible ? 1 : 0,
      duration: Time.t300ms,
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: !widget.isVisible ? null : onPreviousTap,
                  child: Container(
                    width: double.infinity,
                    height: Responsive.instance.deviceHeight(context),
                    color: AppColors.black.withOpacity(0.4),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: !widget.isVisible ? null : onNextTap,
                  child: Container(
                    width: double.infinity,
                    height: Responsive.instance.deviceHeight(context),
                    color: AppColors.black.withOpacity(0.4),
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: AlignmentDirectional.topCenter,
              child: FadeTransition(
                opacity: animation,
                child: Container(
                  margin: AppEdgeInsets.symmetric(vertical: AppPadding.p12),
                  padding: AppEdgeInsets.symmetric(horizontal: AppPadding.p12, vertical: AppPadding.p4),
                  decoration: BoxDecoration(
                    color: AppColors.dracula,
                    borderRadius: AppBorderRadius.all(AppSize.s6),
                  ),
                  child: ValueListenableBuilder<int>(
                    valueListenable: movedSeconds,
                    builder: (context, value, child) =>
                        CustomText("${value > 0 ? "+" : ""}$value ${AppStrings.sec}", color: AppColors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
