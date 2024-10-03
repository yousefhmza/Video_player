import 'package:flutter/material.dart';

import '../../modules/general/view/screens/video_player_screen.dart';
import '../../modules/home/views/screens/home_screen.dart';
import 'navigation.dart';

class RouteGenerator {
  static Route onGenerateRoute(RouteSettings settings) {
    final Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case Routes.homeScreen:
        return platformPageRoute(const HomeScreen(), settings);
      case Routes.videoPlayerScreen:
        return platformPageRoute(VideoPlayerScreen(videoUrl: arguments!["video-url"]), settings);
      default:
        return platformPageRoute(const Scaffold(), settings);
    }
  }
}
