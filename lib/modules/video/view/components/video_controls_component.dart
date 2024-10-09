import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/core/extensions/num_extensions.dart';
import 'package:video_player/modules/video/view/components/black_overlay.dart';
import 'package:video_player/modules/video/view/components/close_mute_controls.dart';
import 'package:video_player/modules/video/view/components/play_pause_rewind_controls.dart';
import 'package:video_player/modules/video/view/components/playback_speed_slider.dart';
import 'package:video_player/modules/video/view/components/speed_and_quality_controls.dart';
import 'package:video_player/modules/video/view/components/volume_slider.dart';

import '../../../../core/resources/resources.dart';
import 'video_scrubber.dart';

class VideoControlsComponent extends StatefulWidget {
  final BetterPlayerController videoController;

  const VideoControlsComponent({required this.videoController, super.key});

  @override
  State<VideoControlsComponent> createState() => _VideoControlsComponentState();
}

class _VideoControlsComponentState extends State<VideoControlsComponent> {
  bool showControls = false;
  Timer? timer;
  ValueNotifier<String> toggleSpeedAndVolumeSliders = ValueNotifier("");

  void onScreenTapped() {
    if (mounted && widget.videoController.videoPlayerController!.value.initialized) {
      showControls = !showControls;
      widget.videoController.setControlsVisibility(showControls);
      showControls ? timer = Timer(Time.t10s, onScreenTapped) : timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onScreenTapped,
      child: StreamBuilder<bool>(
        initialData: false,
        stream: widget.videoController.controlsVisibilityStream,
        builder: (context, snapshot) {
          final bool isVisible = snapshot.data ?? false;
          return Center(
            child: Stack(
              children: [
                BlackOverlay(
                  isVisible: isVisible,
                  videoController: widget.videoController,
                  hideControls: () {
                    onScreenTapped();
                  },
                ),
                AnimatedOpacity(
                  opacity: isVisible ? 1 : 0,
                  duration: Time.t300ms,
                  child: PlayPauseRewindControls(isVisible: isVisible, videoController: widget.videoController),
                ),
                AnimatedOpacity(
                  opacity: isVisible ? 1 : 0,
                  duration: Time.t300ms,
                  child: CloseMuteControls(
                    isVisible: isVisible,
                    videoController: widget.videoController,
                    onLongPress: () => toggleSpeedAndVolumeSliders.value = "volume",
                  ),
                ),
                PositionedDirectional(
                  start: AppSize.s0,
                  end: AppSize.s0,
                  bottom: AppSize.s0,
                  child: AnimatedOpacity(
                    opacity: showControls ? 1 : 0,
                    duration: Time.t300ms,
                    child: Column(
                      children: [
                        SpeedAndQualityControls(
                          isVisible: isVisible,
                          videoController: widget.videoController,
                          onCustomSpeedPressed: () => toggleSpeedAndVolumeSliders.value = "speed",
                        ),
                        VideoScrubber(isVisible: isVisible, videoController: widget.videoController),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: SafeArea(
                    child: SizedBox(
                      width: AppSize.s160.w + AppSize.s16.w,
                      height: AppSize.s56.h,
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: ValueListenableBuilder<String>(
                          valueListenable: toggleSpeedAndVolumeSliders,
                          builder: (context, value, child) => value.isEmpty
                              ? const SizedBox.shrink()
                              : value == "speed"
                                  ? PlaybackSpeedSlider(
                                      videoController: widget.videoController,
                                      disposeSlider: () => toggleSpeedAndVolumeSliders.value = "",
                                    )
                                  : VolumeSlider(
                                      videoController: widget.videoController,
                                      disposeSlider: () => toggleSpeedAndVolumeSliders.value = "",
                                    ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
