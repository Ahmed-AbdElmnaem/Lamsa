import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/routing/routes.dart';
import 'package:lamsa/features/home/ui/widgets/section_header.dart';

import '../../data/model/category_model.dart';
import 'category_card.dart';

class CategorySection extends StatefulWidget {
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
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  String? _selectedId;

  void _onTap(CategoryModel category) {
    setState(() => _selectedId = category.id);
    context.pushNamed(Routes.product, arguments: category.id);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: widget.title, onMorePressed: widget.onMorePressed),
        SizedBox(
          height: 110.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            scrollDirection: Axis.horizontal,
            itemCount: widget.categories.length,
            separatorBuilder: (_, __) => 10.0.width,
            itemBuilder: (_, index) {
              final category = widget.categories[index];
              final isSelected = category.id == _selectedId;

              return GestureDetector(
                onTap: () => _onTap(category),
                child: CategoryCard(
                  icon: category.iconPath,
                  label: category.label,
                  onMorePressed: () => _onTap(category),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
