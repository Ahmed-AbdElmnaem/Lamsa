import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/helpers/extensions.dart';

import '../theming/color_manager.dart';
import '../theming/styles.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = 16,
    this.height = 50,
    this.width,
  });

  final String text;
  final VoidCallback onPressed;

  final Widget? leading;
  final Widget? trailing;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final double borderRadius;
  final double height;
  final double? width; // null ➜ expand

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    lowerBound: 0.0,
    upperBound: 0.05,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(_) => _controller.forward();
  void _onTapUp(_) => _controller.reverse();
  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    final bg = widget.backgroundColor ?? ColorManager.white;
    final fg = widget.foregroundColor ?? Colors.black;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final scale = 1 - _controller.value;
          return Transform.scale(scale: scale, child: child);
        },
        child: Material(
          color: bg,
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          elevation: 6,
          shadowColor: Colors.black.withOpacity(0.25),
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(widget.borderRadius.r),
            splashColor: fg.withOpacity(0.1),
            highlightColor: Colors.transparent,
            child: Container(
              height: widget.height.h,
              width: widget.width?.w ?? double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.leading != null) ...[widget.leading!, 8.0.width],
                  Flexible(
                    child: Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.font16W500.copyWith(color: fg),
                    ),
                  ),
                  if (widget.trailing != null) ...[8.0.width, widget.trailing!],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
