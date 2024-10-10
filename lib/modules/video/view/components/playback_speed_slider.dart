import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/core/extensions/num_extensions.dart';
import 'package:video_player/core/resources/resources.dart';
import 'package:video_player/core/view/views.dart';

import '../../../../core/utils/debouncer.dart';

class PlaybackSpeedSlider extends StatefulWidget {
  final BetterPlayerController videoController;
  final VoidCallback disposeSlider;

  const PlaybackSpeedSlider({required this.videoController, required this.disposeSlider, super.key});

  @override
  State<PlaybackSpeedSlider> createState() => _PlaybackSpeedSliderState();
}

class _PlaybackSpeedSliderState extends State<PlaybackSpeedSlider> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<Offset> animation;
  late double currentSpeed;
  final DeBouncer deBouncer = DeBouncer(debouncingDuration: Time.t3s);

  @override
  void initState() {
    super.initState();
    currentSpeed = widget.videoController.videoPlayerController!.value.speed;
    animationController = AnimationController(vsync: this, duration: Time.t300ms);
    animation = Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
    animationController.forward();
    setTimer();
  }

  void setTimer() {
    // Debouncing technique to call the timer callback after 3 seconds of no activity on the slider
    deBouncer.debounce(
      callback: () async {
        await animationController.reverse();
        animationController.dispose();
        Future.delayed(Time.t300ms, widget.disposeSlider);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: Container(
        width: AppSize.s160.w,
        height: AppSize.s56.h,
        margin: AppEdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p8),
        child: SliderTheme(
          data: SliderThemeData(
            trackHeight: AppSize.s64.w,
            thumbShape: SliderComponentShape.noThumb,
            overlayShape: SliderComponentShape.noThumb,
            valueIndicatorShape: SliderComponentShape.noThumb,
            activeTrackColor: AppColors.white,
            inactiveTrackColor: AppColors.grey300,
            trackShape: const RectangularSliderTrackShape(),
          ),
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              ClipRRect(
                borderRadius: AppBorderRadius.all(AppSize.s16),
                child: Slider(
                  value: currentSpeed,
                  min: 0.1,
                  max: 2,
                  divisions: 19,
                  onChanged: (value) {
                    setState(() {
                      currentSpeed = value;
                      widget.videoController.setSpeed(currentSpeed);
                    });
                    setTimer();
                  },
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: AppEdgeInsets.all(AppPadding.p16),
                    child: CustomIcon(Icons.timer_rounded, color: AppColors.black),
                  ),
                  const Spacer(),
                  CustomText(
                    "X${currentSpeed.toStringAsFixed(1)}",
                    fontWeight: FontWeightManager.bold,
                    autoSized: true,
                    maxLines: 1,
                  ),
                  const HorizontalSpace(AppSize.s8),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
