import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/view/views.dart';

class QualityOption extends PopupMenuItem {
  final BetterPlayerController videoController;
  final BetterPlayerAsmsTrack quality;
  final BetterPlayerAsmsTrack? selectedQuality;
  final void Function(BetterPlayerAsmsTrack selectedQuality) onSelectQuality;

  QualityOption({
    super.key,
    required this.videoController,
    required this.quality,
    required this.selectedQuality,
    required this.onSelectQuality,
  }) : super(
          onTap: () async {
            try {
              videoController.setTrack(quality);
              onSelectQuality(quality);
            } catch (e) {
              Alerts.showToast(e.toString());
            }
          },
          child: CustomText(
            "${quality.height}p",
            fontWeight: quality.bitrate == selectedQuality?.bitrate ? FontWeightManager.bold : FontWeightManager.medium,
            color: quality.bitrate == selectedQuality?.bitrate ? AppColors.primary : AppColors.white,
          ),
        );
}
