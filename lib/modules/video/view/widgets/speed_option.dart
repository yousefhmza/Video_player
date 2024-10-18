import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:video_player/core/utils/alerts.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/views.dart';

class SpeedOption extends PopupMenuItem {
  final BetterPlayerController videoController;
  final String speed;
  final void Function()? onSelectSpeed;

  SpeedOption({super.key, required this.videoController, required this.speed, this.onSelectSpeed})
      : super(
          onTap: () async {
            final double? parsedSpeed = double.tryParse(speed);
            if (onSelectSpeed != null) onSelectSpeed();
            if (parsedSpeed == null) return;

            // Set playback speed if parsed
            try {
              await videoController.setSpeed(parsedSpeed);
            } catch (e) {
              Alerts.showToast(e.toString());
            }
          },
          child: CustomText(
            "$speed X",
            fontWeight: videoController.videoPlayerController?.value.speed.toString() == speed
                ? FontWeightManager.bold
                : FontWeightManager.medium,
            color: videoController.videoPlayerController?.value.speed.toString() == speed
                ? AppColors.primary
                : AppColors.white,
          ),
        );
}
