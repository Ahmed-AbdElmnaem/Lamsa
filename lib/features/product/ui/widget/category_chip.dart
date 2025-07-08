import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';

class CategoryChip extends StatefulWidget {
  const CategoryChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.95,
      upperBound: 1.05,
    );
    if (widget.selected) _ctrl.forward();
  }

  @override
  void didUpdateWidget(covariant CategoryChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != oldWidget.selected) {
      if (widget.selected) {
        _ctrl.forward();
      } else {
        _ctrl.reverse();
      }
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder:
            (_, child) => Transform.scale(
              scale: widget.selected ? _ctrl.value : 1.0,
              child: child,
            ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.center,
          height: 30.h,
          width: 100.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color:
                widget.selected
                    ? ColorManager.mainColor.withOpacity(0.15)
                    : ColorManager.white,
            border: Border.all(
              color: widget.selected ? ColorManager.mainColor : Colors.black26,
              width: 1.5,
            ),
          ),
          child: Text(
            widget.label,
            style: Styles.font14W500.copyWith(
              color: widget.selected ? ColorManager.mainColor : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
