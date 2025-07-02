import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/localization/locale_keys.dart';
import 'package:lamsa/core/widgets/custom_text_field.dart';

class FormRegisterScreen extends StatelessWidget {
  const FormRegisterScreen({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          controller: nameController,
          hintText: LocaleKeys.full_name_hint.tr(),
          keyboardType: TextInputType.name,
          validator:
              (value) =>
                  value!.isEmpty ? LocaleKeys.full_name_validator.tr() : null,
          prefixIcon: const Icon(Icons.person, color: Colors.white),
        ),
        20.0.height,
        AppTextFormField(
          controller: emailController,
          hintText: LocaleKeys.email_hint.tr(),
          keyboardType: TextInputType.emailAddress,
          validator:
              (value) =>
                  value!.isEmpty ? LocaleKeys.email_validator.tr() : null,
          prefixIcon: const Icon(Icons.email_outlined, color: Colors.white),
        ),
        20.0.height,
        AppTextFormField(
          controller: passwordController,
          hintText: LocaleKeys.password_hint.tr(),
          obsecureText: true,
          keyboardType: TextInputType.visiblePassword,
          validator:
              (value) =>
                  value!.isEmpty ? LocaleKeys.password_validator.tr() : null,
        ),
        20.0.height,
        AppTextFormField(
          controller: confirmPasswordController,
          hintText: LocaleKeys.confirm_password_hint.tr(),
          obsecureText: true,
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            if (value!.isEmpty) {
              return LocaleKeys.confirm_password_validator.tr();
            } else if (value != passwordController.text) {
              return LocaleKeys.passwords_not_matching.tr();
            }
            return null;
          },
        ),
      ],
    );
  }
}
