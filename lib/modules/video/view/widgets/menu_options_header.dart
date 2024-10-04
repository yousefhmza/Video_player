import 'package:flutter/material.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/views.dart';

class MenuOptionsHeader extends PopupMenuItem {
  final String title;

  MenuOptionsHeader({super.key, required this.title})
      : super(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(title, color: AppColors.white),
                  HorizontalSpace(AppSize.s4),
                  CustomIcon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.white,
                    size: AppSize.s16,
                  ),
                ],
              ),
              VerticalSpace(AppSize.s8),
              Divider(height: AppSize.s1, color: AppColors.white)
            ],
          ),
        );
}
