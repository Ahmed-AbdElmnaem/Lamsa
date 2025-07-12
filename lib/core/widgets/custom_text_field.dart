import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/theming/color_manager.dart';

import '../theming/styles.dart';

class AppTextFormField extends StatefulWidget {
  final EdgeInsetsGeometry? contentPadding;
  final String hintText;
  final Widget? suffixIcon;
  final bool? obsecureText;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errordBorder;
  final InputBorder? focusedErrorBorder;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final Color? backgroundColor;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final Function(String? value) validator;
  final Function()? onTap;
  final Function(String)? onChanged;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final InputBorder? border;

  const AppTextFormField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.obsecureText = false,
    this.enabledBorder,
    this.focusedBorder,
    this.hintStyle,
    this.contentPadding,
    this.keyboardType,
    this.backgroundColor,
    this.controller,
    required this.validator,
    this.errordBorder,
    this.focusedErrorBorder,
    this.prefixIcon,
    this.onTap,
    this.onChanged,
    this.maxLines,
    this.minLines,
    this.focusNode,
    this.border,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = widget.obsecureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: true,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      maxLines: (widget.obsecureText! && isObscure) ? 1 : widget.maxLines ?? 1,
      minLines: (widget.obsecureText! && isObscure) ? 1 : widget.minLines ?? 1,
      focusNode: widget.focusNode ?? FocusNode(),
      controller: widget.controller,
      obscureText: widget.obsecureText! && isObscure,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      inputFormatters:
          widget.keyboardType == TextInputType.number
              ? [FilteringTextInputFormatter.digitsOnly]
              : widget.keyboardType == TextInputType.emailAddress
              ? [
                FilteringTextInputFormatter.deny(
                  RegExp(r'[(),:;<>[\]{}|\\#\\$%\^&\*\+=\/!\?]'),
                  replacementString: '',
                ),
              ]
              : [],
      style: Styles.font16W400.copyWith(color: Colors.white),
      decoration: InputDecoration(
        border: widget.border ?? InputBorder.none,

        prefixIcon: widget.prefixIcon,
        filled: true,
        fillColor: widget.backgroundColor ?? Colors.white.withOpacity(0.07),
        isDense: true,
        contentPadding:
            widget.contentPadding ??
            EdgeInsets.symmetric(vertical: 16.h, horizontal: 14.w),
        enabledBorder:
            widget.enabledBorder ??
            buildOutLineBorder(color: Colors.white.withOpacity(0.2)),
        focusedBorder: widget.focusedBorder ?? buildOutLineBorder(),
        errorBorder:
            widget.errordBorder ??
            buildOutLineBorder(color: ColorManager.error),
        focusedErrorBorder:
            widget.focusedErrorBorder ?? buildOutLineBorder(color: Colors.red),
        hintStyle:
            widget.hintStyle ??
            Styles.font16W400.copyWith(color: Colors.white70),
        hintText: widget.hintText,
        suffixIcon:
            widget.suffixIcon ??
            (widget.obsecureText!
                ? IconButton(
                  onPressed: () {
                    setState(() => isObscure = !isObscure);
                  },
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white.withOpacity(0.8),
                  ),
                )
                : null),
      ),
      validator: (value) => widget.validator(value),
    );
  }

  OutlineInputBorder buildOutLineBorder({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.r),
      borderSide: BorderSide(
        color: color ?? ColorManager.mainColor.withOpacity(0.6),
        width: 1.3,
      ),
    );
  }
}
