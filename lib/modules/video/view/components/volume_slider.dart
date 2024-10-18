import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:video_player/core/extensions/num_extensions.dart';
import 'package:video_player/core/resources/resources.dart';
import 'package:video_player/core/utils/debouncer.dart';
import 'package:video_player/core/view/views.dart';

class VolumeSlider extends StatefulWidget {
  final BetterPlayerController videoController;
  final VoidCallback disposeSlider;

  const VolumeSlider({required this.videoController, required this.disposeSlider, super.key});

  @override
  State<VolumeSlider> createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<Offset> animation;
  late double currentVolume;
  final DeBouncer deBouncer = DeBouncer(debouncingDuration: Time.t3s);

  @override
  void initState() {
    super.initState();
    currentVolume = widget.videoController.videoPlayerController!.value.volume;
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
        width: AppSize.s56.w,
        height: AppSize.s160.h,
        margin: AppEdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: RotatedBox(
          quarterTurns: -1,
          child: SliderTheme(
            data: SliderThemeData(
              trackHeight: AppSize.s60.w,
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
                    value: currentVolume,
                    min: 0,
                    max: 1,
                    onChanged: (value) {
                      setState(() {
                        currentVolume = value;
                        widget.videoController.setVolume(currentVolume);
                      });
                      setTimer();
                    },
                  ),
                ),
                Row(
                  children: [
                    RotatedBox(
                      quarterTurns: 1,
                      child: Padding(
                        padding: AppEdgeInsets.all(AppPadding.p16),
                        child: CustomIcon.svg(AppIcons.volume, color: AppColors.black, size: AppSize.s18),
                      ),
                    ),
                    const Spacer(),
                    RotatedBox(
                      quarterTurns: 1,
                      child: CustomText(
                        (currentVolume * 100).toStringAsFixed(0),
                        fontWeight: FontWeightManager.bold,
                        autoSized: true,
                        maxLines: 1,
                      ),
                    ),
                    const HorizontalSpace(AppSize.s8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
