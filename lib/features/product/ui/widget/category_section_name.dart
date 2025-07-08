import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/features/home/data/model/category_model.dart';
import 'package:lamsa/features/product/ui/widget/category_chip.dart';

class CategorySectionName extends StatefulWidget {
  const CategorySectionName({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onTap,
  });

  final List<CategoryModel> categories;
  final String? selectedId;
  final ValueChanged<String?> onTap;

  @override
  State<CategorySectionName> createState() => _CategorySectionNameState();
}

class _CategorySectionNameState extends State<CategorySectionName>
    with AutomaticKeepAliveClientMixin {
  final _scroll = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void didUpdateWidget(covariant CategorySectionName oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedId != oldWidget.selectedId) {
      _scrollToSelected();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelected());
  }

  void _scrollToSelected() {
    final index =
        widget.selectedId == null
            ? 0
            : widget.categories.indexWhere((c) => c.id == widget.selectedId) +
                1;
    if (index < 0) return;

    _scroll.animateTo(
      index * (100.w + 10.w), // عرض الـ chip + المسافة
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        controller: _scroll,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length + 1,
        separatorBuilder: (_, __) => 10.0.width,
        itemBuilder: (_, index) {
          if (index == 0) {
            return CategoryChip(
              label: 'الكل',
              selected: widget.selectedId == null,
              onTap: () => widget.onTap(null),
            );
          }
          final category = widget.categories[index - 1];
          return CategoryChip(
            label: category.label,
            selected: category.id == widget.selectedId,
            onTap: () => widget.onTap(category.id),
          );
        },
      ),
    );
  }
}
