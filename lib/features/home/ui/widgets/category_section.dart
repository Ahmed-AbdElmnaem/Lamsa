import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/features/home/ui/widgets/section_header.dart';

import '../../data/model/category_model.dart';
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
        SectionHeader(title: title, onMorePressed: onMorePressed),
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
