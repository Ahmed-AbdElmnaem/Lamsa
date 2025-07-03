import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/utils/assets_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.onMenuTap});

  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.mainColor,
      elevation: 1,

      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: onMenuTap,
        color: Colors.white,
      ),
      centerTitle: true,

      title: Image.asset(AssetsManager.logo, fit: BoxFit.cover),
      // Trailing actions.
      actions: [
        Padding(
          padding: EdgeInsetsDirectional.only(end: 16.w),
          child: Stack(
            children: [
              Image.asset(
                AssetsManager.myPurchases,
                width: 20.w,
                height: 20.w,
                fit: BoxFit.contain,
              ),
              Container(
                width: 7.0.w,
                height: 7.0.w,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
