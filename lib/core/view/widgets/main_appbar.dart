import 'package:flutter/material.dart';
import 'package:video_player/core/extensions/num_extensions.dart';

import '../views.dart';
import '../../resources/resources.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final Color? bgColor;
  final List<Widget>? actions;

  const MainAppbar({
    required this.title,
    this.leading,
    this.actions,
    this.bgColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      leading: leading,
      showDefaultBackButton: true,
      actions: actions,
      bgColor: bgColor,
      title: CustomText(
        title,
        fontSize: FontSize.s18,
        fontWeight: FontWeightManager.semiBold,
        color: AppColors.black,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}
