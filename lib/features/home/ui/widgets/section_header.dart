import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.onMorePressed});

  final String title;
  final VoidCallback? onMorePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      child: Row(
        children: [
          Text(
            title,
            style: Styles.font18W600.copyWith(color: ColorManager.mainColor),
          ),
          const Spacer(),
          if (onMorePressed != null)
            TextButton(
              onPressed: onMorePressed,
              child: Text(
                'المزيد',
                style: Styles.font16W500.copyWith(
                  color: ColorManager.mainColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
