import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/core/utils/alerts.dart';
import 'package:video_player/core/utils/debouncer.dart';

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

class _BlackOverlayState extends State<BlackOverlay> {
  int leftTapCount = 0;
  int rightTapCount = 0;
  final DeBouncer deBouncer = DeBouncer(debouncingDuration: Time.t300ms);

  Future<void> onNextTap() async {
    // Debouncing technique seeking the desired video position after stop tapping on the right or left sides of screen
    rightTapCount++;
    final int movedSeconds = 10 * (rightTapCount - 1);
    if (rightTapCount > 1) {
      // await Alerts.cancelToast();
      Alerts.showToast("+$movedSeconds ${AppStrings.sec}", toastGravity: ToastGravity.TOP, bgColor: AppColors.dracula);
    }
    deBouncer.debounce(
      callback: () {
        if (rightTapCount > 1) {
          widget.videoController.seekTo(
            widget.videoController.videoPlayerController!.value.position + Duration(seconds: movedSeconds),
          );
        } else {
          widget.hideControls();
        }
        rightTapCount = 0;
      },
    );
  }

  Future<void> onPreviousTap() async {
    leftTapCount++;
    final int movedSeconds = 10 * (leftTapCount - 1);
    if (leftTapCount > 1) {
      // await Alerts.cancelToast();
      Alerts.showToast("-$movedSeconds ${AppStrings.sec}", toastGravity: ToastGravity.TOP, bgColor: AppColors.dracula);
    }
    deBouncer.debounce(
      callback: () {
        if (leftTapCount > 1) {
          widget.videoController.seekTo(
            widget.videoController.videoPlayerController!.value.position - Duration(seconds: movedSeconds),
          );
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
      child: Row(
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
    );
  }
}
