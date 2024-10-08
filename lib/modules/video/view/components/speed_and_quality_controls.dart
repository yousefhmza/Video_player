import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/core/extensions/num_extensions.dart';
import 'package:video_player/core/resources/resources.dart';
import 'package:video_player/core/view/views.dart';
import 'package:video_player/modules/video/view/widgets/menu_options_header.dart';
import 'package:video_player/modules/video/view/widgets/quality_option.dart';
import 'package:video_player/modules/video/view/widgets/speed_option.dart';

class SpeedAndQualityControls extends StatefulWidget {
  final bool isVisible;
  final BetterPlayerController videoController;
  final VoidCallback onCustomSpeedPressed;

  const SpeedAndQualityControls({
    required this.isVisible,
    required this.videoController,
    required this.onCustomSpeedPressed,
    super.key,
  });

  @override
  State<SpeedAndQualityControls> createState() => _SpeedAndQualityControlsState();
}

class _SpeedAndQualityControlsState extends State<SpeedAndQualityControls> {
  bool isLandscape = false;
  List<BetterPlayerAsmsTrack> availableTrackQualities = [];
  List<String> availableSpeeds = [AppStrings.custom, "2.0", "1.75", "1.5", "1.25", "1.0", "0.5", "0.25"];
  BetterPlayerAsmsTrack? selectedTrackQuality;
  String selectedSpeed = "1.0";

  @override
  void initState() {
    super.initState();
    widget.videoController.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
        availableTrackQualities =
            widget.videoController.betterPlayerAsmsTracks.where((track) => track.height != null).toList();
        selectedTrackQuality = availableTrackQualities.first;
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
            enabled: widget.isVisible,
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
            enabled: widget.isVisible,
            color: AppColors.dracula,
            elevation: AppSize.s0,
            constraints: BoxConstraints(maxWidth: AppSize.s160.w),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s8)),
            position: PopupMenuPosition.over,
            offset: Offset(AppSize.s24, -AppSize.s100),
            child: CustomIcon.svg(AppIcons.speed, size: AppSize.s18),
            itemBuilder: (context) => [
              MenuOptionsHeader(title: AppStrings.playbackSpeed),
              ...List.generate(
                availableSpeeds.length,
                (index) => SpeedOption(
                  videoController: widget.videoController,
                  speed: availableSpeeds[index],
                  selectedSpeed: selectedSpeed,
                  onSelectSpeed: () {
                    if (index == 0) widget.onCustomSpeedPressed();
                    selectedSpeed = availableSpeeds[index];
                  },
                ),
              ),
            ],
          ),
          const HorizontalSpace(AppSize.s30),
          InkWell(
            onTap: widget.isVisible
                ? () {
                    isLandscape = !isLandscape;
                    if (isLandscape) {
                      SystemChrome.setPreferredOrientations(
                        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
                      );
                    } else {
                      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                    }
                  }
                : null,
            child: CustomIcon.svg(AppIcons.fullscreen, size: AppSize.s16),
          ),
        ],
      ),
    );
  }
}
