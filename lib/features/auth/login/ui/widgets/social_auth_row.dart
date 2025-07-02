import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/localization/locale_keys.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';
import 'package:lamsa/core/utils/assets_manager.dart';

class SocialAuthRow extends StatelessWidget {
  const SocialAuthRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                Expanded(
                  child: Divider(color: ColorManager.secondColor, thickness: 1),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    LocaleKeys.or_continue_with.tr(),
                    style: Styles.font14W400.copyWith(color: Colors.white54),
                  ),
                ),
                Expanded(
                  child: Divider(color: ColorManager.secondColor, thickness: 1),
                ),
              ],
            ),
          ),
          16.0.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconOnlyButton(
                asset: AssetsManager.google,
                background: Colors.white,
                onTap: () {},
              ),
              16.0.width,
              IconOnlyButton(
                asset: AssetsManager.facebook,
                background: const Color(0xFF1877F2),
                onTap: () {},
              ),
              if (Theme.of(context).platform == TargetPlatform.iOS) ...[
                16.0.width,
                IconOnlyButton(
                  asset: 'assets/icons/apple.png',
                  background: Colors.black,
                  onTap: () {},
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class IconOnlyButton extends StatelessWidget {
  const IconOnlyButton({
    super.key,
    required this.asset,
    required this.background,
    required this.onTap,
  });

  final String asset;
  final Color background;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50.w,
        height: 50.w,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(12.w),
        child: Image.asset(asset, fit: BoxFit.contain),
      ),
    );
  }
}
