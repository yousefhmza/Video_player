import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/core/utils/alerts.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/views.dart';

class SpeedOption extends PopupMenuItem {
  final BetterPlayerController videoController;
  final double speed;

  SpeedOption({super.key, required this.videoController, required this.speed})
      : super(
          onTap: () async {
            try {
              await videoController.setSpeed(speed);
            } catch (e) {
              Alerts.showToast(e.toString());
            }
          },
          child: CustomText(
            "$speed X",
            fontWeight: videoController.videoPlayerController!.value.speed == speed
                ? FontWeightManager.bold
                : FontWeightManager.medium,
            color: videoController.videoPlayerController!.value.speed == speed ? AppColors.primary : AppColors.white,
          ),
        );
}
