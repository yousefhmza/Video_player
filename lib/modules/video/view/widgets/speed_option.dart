import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/core/utils/alerts.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/views.dart';

class SpeedOption extends PopupMenuItem {
  final BetterPlayerController videoController;
  final String speed;
  final String selectedSpeed;
  final void Function() onSelectSpeed;

  SpeedOption({
    super.key,
    required this.videoController,
    required this.speed,
    required this.selectedSpeed,
    required this.onSelectSpeed,
  }) : super(
          onTap: () async {
            final double? parsedSpeed = double.tryParse(speed);
            onSelectSpeed();
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
            fontWeight: speed == selectedSpeed ? FontWeightManager.bold : FontWeightManager.medium,
            color: speed == selectedSpeed ? AppColors.primary : AppColors.white,
          ),
        );
}
