import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/views.dart';

class PlayPauseRewindControls extends StatelessWidget {
  final bool isVisible;
  final BetterPlayerController videoController;

  const PlayPauseRewindControls({required this.isVisible, required this.videoController, super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: videoController.videoPlayerController!,
      builder: (context, value, child) => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: isVisible ? () => videoController.seekTo(value.position - Time.t10s) : null,
              child: const CustomIcon.svg(AppIcons.backwards, size: AppSize.s36),
            ),
            const HorizontalSpace(AppSize.s32),
            InkWell(
              onTap: isVisible
                  ? value.isPlaying
                      ? videoController.pause
                      : videoController.play
                  : null,
              child: Container(
                padding: AppEdgeInsets.all(AppPadding.p8),
                decoration: ShapeDecoration(
                  shape: const CircleBorder(),
                  color: AppColors.white.withOpacity(0.3),
                ),
                child: CustomIcon(
                  value.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  size: AppSize.s52,
                  color: AppColors.white,
                ),
              ),
            ),
            const HorizontalSpace(AppSize.s32),
            InkWell(
              onTap: isVisible ? () => videoController.seekTo(value.position + Time.t10s) : null,
              child: const CustomIcon.svg(AppIcons.forward, size: AppSize.s36),
            ),
          ],
        ),
      ),
    );
  }
}
