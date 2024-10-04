import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/core/extensions/non_null_extensions.dart';
import 'package:video_player/core/extensions/num_extensions.dart';
import 'package:video_player/core/resources/resources.dart';
import 'package:video_player/core/view/views.dart';
import 'package:video_player/modules/general/view/widgets/menu_options_header.dart';
import 'package:video_player/modules/general/view/widgets/quality_option.dart';
import 'package:video_player/modules/general/view/widgets/speed_option.dart';

class SpeedAndQualityControls extends StatefulWidget {
  final BetterPlayerController videoController;

  const SpeedAndQualityControls({required this.videoController, super.key});

  @override
  State<SpeedAndQualityControls> createState() => _SpeedAndQualityControlsState();
}

class _SpeedAndQualityControlsState extends State<SpeedAndQualityControls> {
  bool isLandscape = false;
  List<BetterPlayerAsmsTrack> availableTrackQualities = [];
  BetterPlayerAsmsTrack? selectedTrackQuality;

  @override
  void initState() {
    super.initState();
    widget.videoController.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
        availableTrackQualities =
            widget.videoController.betterPlayerAsmsTracks.where((track) => track.height.orZero != 0).toList();
        selectedTrackQuality = widget.videoController.betterPlayerAsmsTrack;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppEdgeInsets.symmetric(horizontal: AppPadding.p24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PopupMenuButton(
            color: AppColors.dracula,
            elevation: AppSize.s0,
            constraints: BoxConstraints(maxWidth: AppSize.s160.w),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s8)),
            position: PopupMenuPosition.over,
            offset: Offset(AppSize.s24, -AppSize.s100),
            child: CustomIcon(Icons.video_collection_rounded, size: AppSize.s20, color: AppColors.white),
            itemBuilder: (context) => [
              MenuOptionsHeader(title: AppStrings.quality),
              ...List.generate(
                availableTrackQualities.length,
                (index) => QualityOption(
                  videoController: widget.videoController,
                  quality: availableTrackQualities[index],
                  selectedQuality: selectedTrackQuality,
                  onSelectQuality: (quality) => selectedTrackQuality = quality,
                ),
              ),
            ],
          ),
          const HorizontalSpace(AppSize.s30),
          PopupMenuButton(
            color: AppColors.dracula,
            elevation: AppSize.s0,
            constraints: BoxConstraints(maxWidth: AppSize.s160.w),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s8)),
            position: PopupMenuPosition.over,
            offset: Offset(AppSize.s24, -AppSize.s100),
            child: CustomIcon.svg(AppIcons.speed, size: AppSize.s18),
            itemBuilder: (context) => [
              MenuOptionsHeader(title: AppStrings.playbackSpeed),
              SpeedOption(videoController: widget.videoController, speed: 2.0),
              SpeedOption(videoController: widget.videoController, speed: 1.75),
              SpeedOption(videoController: widget.videoController, speed: 1.5),
              SpeedOption(videoController: widget.videoController, speed: 1.25),
              SpeedOption(videoController: widget.videoController, speed: 1.0),
              SpeedOption(videoController: widget.videoController, speed: 0.5),
              SpeedOption(videoController: widget.videoController, speed: 0.25),
            ],
          ),
          const HorizontalSpace(AppSize.s30),
          InkWell(
            onTap: () {
              isLandscape = !isLandscape;
              if (isLandscape) {
                SystemChrome.setPreferredOrientations(
                  [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
                );
              } else {
                SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
              }
            },
            child: CustomIcon.svg(AppIcons.fullscreen, size: AppSize.s16),
          ),
        ],
      ),
    );
  }
}
