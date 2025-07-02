import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/localization/locale_keys.dart';
import 'package:lamsa/core/theming/styles.dart';
import 'package:lamsa/core/widgets/custom_text_field.dart';

class FormLoginScreen extends StatelessWidget {
  const FormLoginScreen({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          suffixIcon: const Icon(Icons.email_outlined, color: Colors.white),
          controller: emailController,
          hintText: LocaleKeys.email_hint.tr(),
          keyboardType: TextInputType.emailAddress,
          validator:
              (value) =>
                  value!.isEmpty ? LocaleKeys.email_validator.tr() : null,
        ),

        20.0.height,
        AppTextFormField(
          keyboardType: TextInputType.visiblePassword,
          obsecureText: true,
          controller: passwordController,
          hintText: LocaleKeys.password_hint.tr(),
          validator:
              (value) =>
                  value!.isEmpty ? LocaleKeys.password_validator.tr() : null,
        ),

        10.0.height,
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              // رايح لنسيت كلمة المرور
            },
            child: Text(
              LocaleKeys.forgot_password.tr(),
              style: Styles.font14W400.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
