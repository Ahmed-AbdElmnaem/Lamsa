import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';

import '../data/model/category_model.dart';
import 'category_card.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({
    super.key,
    required this.categories,
    this.title = 'التصنيفات',
    this.onMorePressed,
  });

  final List<CategoryModel> categories;

  final String title;

  final VoidCallback? onMorePressed;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: title, onMorePressed: onMorePressed),
        SizedBox(
          height: 110.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => 10.0.width,
            itemBuilder: (_, index) {
              final category = categories[index];
              return CategoryCard(
                icon: category.iconPath,
                label: category.label,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.onMorePressed});

  final String title;
  final VoidCallback? onMorePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
                'المزيد ..',
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
