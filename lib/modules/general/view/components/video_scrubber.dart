import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/core/extensions/num_extensions.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/view/views.dart';

class VideoScrubber extends StatefulWidget {
  final VideoPlayerValue playerValue;
  final BetterPlayerController videoController;

  const VideoScrubber({required this.playerValue, required this.videoController, super.key});

  @override
  State<VideoScrubber> createState() => _VideoScrubberState();
}

class _VideoScrubberState extends State<VideoScrubber> {
  double _value = 0.0;

  @override
  void didUpdateWidget(covariant VideoScrubber oldWidget) {
    super.didUpdateWidget(oldWidget);
    int position = oldWidget.playerValue.position.inSeconds;
    int duration = oldWidget.playerValue.duration?.inSeconds ?? 0;
    setState(() {
      _value = position / duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: AppEdgeInsets.all(AppPadding.p16).copyWith(top: AppPadding.p0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppEdgeInsets.symmetric(horizontal: AppPadding.p6),
              child: CustomText(
                "${Utils.getDurations(widget.playerValue.position)} / ${Utils.getDurations(widget.videoController.videoPlayerController!.value.duration ?? const Duration())}",
                fontSize: FontSize.s12,
                color: AppColors.white,
              ),
            ),
            const VerticalSpace(AppSize.s8),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbColor: AppColors.white,
                trackHeight: AppSize.s3.h,
                overlayShape: SliderComponentShape.noOverlay,
              ),
              child: Slider(
                value: _value.isNaN ? 0 : _value,
                inactiveColor: Colors.grey,
                min: 0.0,
                max: 1.0,
                onChanged: (newValue) {
                  setState(() => _value = newValue);
                  final newProgress = Duration(
                    milliseconds:
                        (_value * widget.videoController.videoPlayerController!.value.duration!.inMilliseconds).toInt(),
                  );
                  widget.videoController.seekTo(newProgress);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
