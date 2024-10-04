import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/modules/video/view/components/video_controls_component.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/views.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({required this.videoUrl, super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late BetterPlayerController _videoController;

  void setupVideoPlayer() {
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.videoUrl,
      useAsmsSubtitles: true,
      useAsmsTracks: true,
      bufferingConfiguration: const BetterPlayerBufferingConfiguration(maxBufferMs: 7 * 60 * 1000),
      cacheConfiguration: const BetterPlayerCacheConfiguration(
        useCache: true,
        preCacheSize: 100 * 1024 * 1024, //100 MB
        maxCacheSize: 100 * 1024 * 1024, //100 MB
        maxCacheFileSize: 100 * 1024 * 1024, //100 MB
      ),
      asmsTrackNames: ["240p", "360p", "480p", "720p", "1080p"],
    );
    _videoController = BetterPlayerController(
      const BetterPlayerConfiguration(
        aspectRatio: 16 / 9,
        autoPlay: true,
        allowedScreenSleep: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          playerTheme: BetterPlayerTheme.custom,
          enablePlaybackSpeed: true,
          enableQualities: true,
        ),
      ),
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  @override
  void initState() {
    super.initState();
    setupVideoPlayer();
  }

  @override
  void dispose() {
    _videoController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatusBar(
      isLight: true,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Stack(
          children: [
            Center(
              child: ValueListenableBuilder(
                valueListenable: _videoController.videoPlayerController!,
                builder: (context, value, child) => value.initialized
                    ? AspectRatio(aspectRatio: 16 / 9, child: BetterPlayer(controller: _videoController))
                    : const LoadingSpinner(color: AppColors.white),
              ),
            ),
            VideoControlsComponent(videoController: _videoController),
          ],
        ),
      ),
    );
  }
}
