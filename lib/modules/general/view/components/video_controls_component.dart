import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/core/services/responsive/responsive_service.dart';
import 'package:video_player/modules/general/view/components/close_mute_controls.dart';
import 'package:video_player/modules/general/view/components/play_pause_seek_controls.dart';
import 'package:video_player/modules/general/view/components/speed_and_quality_controls.dart';

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

  void onScreenTapped() {
    if (mounted) {
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
                // Black overlay
                AnimatedOpacity(
                  opacity: isVisible ? 1 : 0,
                  duration: Time.t300ms,
                  child: Container(
                    width: Responsive.instance.deviceWidth(context),
                    height: Responsive.instance.deviceHeight(context),
                    color: AppColors.black.withOpacity(0.4),
                  ),
                ),
                AnimatedOpacity(
                  opacity: isVisible ? 1 : 0,
                  duration: Time.t300ms,
                  child: PlayPauseSeekControls(isVisible: isVisible, videoController: widget.videoController),
                ),
                AnimatedOpacity(
                  opacity: isVisible ? 1 : 0,
                  duration: Time.t300ms,
                  child: CloseMuteControls(isVisible: isVisible, videoController: widget.videoController),
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
                        SpeedAndQualityControls(videoController: widget.videoController),
                        ValueListenableBuilder(
                          valueListenable: widget.videoController.videoPlayerController!,
                          builder: (context, value, child) => VideoScrubber(
                            videoController: widget.videoController,
                            playerValue: value,
                          ),
                        )
                      ],
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
