import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:video_player/config/navigation/navigation.dart';
import 'package:video_player/core/resources/resources.dart';
import 'package:video_player/core/view/views.dart';

class CloseMuteControls extends StatelessWidget {
  final bool isVisible;
  final BetterPlayerController videoController;
  final VoidCallback onPress;

  const CloseMuteControls({
    required this.isVisible,
    required this.videoController,
    required this.onPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppEdgeInsets.all(AppPadding.p16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: isVisible ? () => NavigationService.goBack() : null,
              child: CustomIcon.svg(AppIcons.close),
            ),
            GestureDetector(
              onTap: onPress,
              onLongPress: isVisible
                  ? () => videoController.videoPlayerController!.value.volume == 0
                      ? videoController.setVolume(1)
                      : videoController.setVolume(0)
                  : null,
              child: ValueListenableBuilder(
                valueListenable: videoController.videoPlayerController!,
                builder: (context, value, child) => CustomIcon.svg(
                  value.volume == 0 ? AppIcons.volumeMuted : AppIcons.volume,
                  size: AppSize.s20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
