import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/localization/locale_keys.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';

class FooterRegisterScreen extends StatelessWidget {
  const FooterRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.have_account.tr(),
          style: Styles.font14W400.copyWith(color: Colors.white70),
        ),
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(
            LocaleKeys.login.tr(),
            style: Styles.font14W400.copyWith(
              color: ColorManager.secondColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
