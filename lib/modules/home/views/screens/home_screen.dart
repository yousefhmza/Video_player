import 'package:flutter/material.dart';
import 'package:video_player/config/navigation/navigation.dart';
import 'package:video_player/core/resources/resources.dart';

import '../../../../core/view/views.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> videosUrls = [
    "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8",
    "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8",
    "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(title: AppStrings.videosList),
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) => ListTile(
            title: CustomText(videosUrls[index]),
            onTap: () => NavigationService.push(
              Routes.videoPlayerScreen,
              arguments: {"video-url": videosUrls[index]},
            ),
          ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: videosUrls.length,
        ),
      ),
    );
  }
}
