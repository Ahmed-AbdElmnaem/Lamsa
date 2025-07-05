import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.icon, required this.label});
  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 65.h,
          width: 65.h,
          decoration: BoxDecoration(
            color: ColorManager.mainColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.r),
              child: Image.asset(
                icon,
                fit: BoxFit.cover,
                width: 40.w,
                height: 40.w,
              ),
            ),
          ),
        ),
        6.0.height,
        Text(
          label,
          style: Styles.font12W400.copyWith(color: ColorManager.mainColor),
        ),
      ],
    );
  }
}
