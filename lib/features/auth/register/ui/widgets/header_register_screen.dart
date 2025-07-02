import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/localization/locale_keys.dart';
import 'package:lamsa/core/theming/styles.dart';
import 'package:lamsa/core/utils/assets_manager.dart';

class HeaderRegisterScreen extends StatelessWidget {
  const HeaderRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            AssetsManager.logoGif,
            width: double.infinity,
            height: 200.h,
            fit: BoxFit.cover,
          ),
        ),
        10.0.height,
        Text(
          LocaleKeys.register_title.tr(),
          style: Styles.font24W600.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        10.0.height,
        Text(
          LocaleKeys.register_subtitle.tr(),
          style: Styles.font16W400.copyWith(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
