import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:video_player/core/extensions/num_extensions.dart';
import 'package:video_player/core/services/responsive/responsive_service.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/view/views.dart';

class VideoScrubber extends StatefulWidget {
  final bool isVisible;
  final BetterPlayerController videoController;

  const VideoScrubber({required this.isVisible, required this.videoController, super.key});

  @override
  State<VideoScrubber> createState() => _VideoScrubberState();
}

class _VideoScrubberState extends State<VideoScrubber> {
  final ValueNotifier<double> _bufferedPosition = ValueNotifier(0.0);
  final ValueNotifier<double> _currentPosition = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    widget.videoController.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
        _updateBufferingState();
      }
    });
  }

  void _updateBufferingState() {
    final videoController = widget.videoController.videoPlayerController!;

    if (videoController.value.initialized) {
      // Get the total duration of the video
      final totalDuration = videoController.value.duration!.inMilliseconds.toDouble();

      // Get the buffered end position
      if (videoController.value.buffered.isNotEmpty) {
        final bufferedEnd = videoController.value.buffered.last.end.inMilliseconds.toDouble();
        _bufferedPosition.value = (bufferedEnd / totalDuration).clamp(0.0, 1.0);
      }

      // Get the current position
      final currentPosition = videoController.value.position.inMilliseconds.toDouble();
      _currentPosition.value = (currentPosition / totalDuration).clamp(0.0, 1.0);
    }
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
            ValueListenableBuilder(
              valueListenable: widget.videoController.videoPlayerController!,
              builder: (context, value, child) => Padding(
                padding: AppEdgeInsets.symmetric(horizontal: AppPadding.p6),
                child: CustomText(
                  "${Utils.getDurations(value.position)} / ${Utils.getDurations(widget.videoController.videoPlayerController!.value.duration ?? const Duration())}",
                  fontSize: FontSize.s12,
                  color: AppColors.white,
                ),
              ),
            ),
            const VerticalSpace(AppSize.s8),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbColor: AppColors.white,
                trackHeight: AppSize.s3.h,
                overlayShape: SliderComponentShape.noOverlay,
                inactiveTrackColor: Colors.green,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: Responsive.instance.deviceWidth(context),
                    height: AppSize.s5,
                    margin: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                    decoration: const ShapeDecoration(color: AppColors.grey500, shape: StadiumBorder()),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: ValueListenableBuilder(
                      valueListenable: _bufferedPosition,
                      builder: (context, value, child) => Container(
                        width: value * Responsive.instance.deviceWidth(context),
                        height: AppSize.s5,
                        margin: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                        decoration: const ShapeDecoration(color: AppColors.grey300, shape: StadiumBorder()),
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _currentPosition,
                    builder: (context, value, child) => Slider(
                      value: value,
                      inactiveColor: Colors.transparent,
                      min: 0.0,
                      max: 1.0,
                      onChanged: (newValue) {
                        if (!widget.isVisible) return;
                        _currentPosition.value = newValue;
                        final newProgress = Duration(
                          milliseconds: (_currentPosition.value *
                                  widget.videoController.videoPlayerController!.value.duration!.inMilliseconds)
                              .toInt(),
                        );
                        widget.videoController.seekTo(newProgress);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
