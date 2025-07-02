import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/localization/locale_keys.dart';
import 'package:lamsa/core/widgets/custom_text_field.dart';

class FormRegisterScreen extends StatefulWidget {
  const FormRegisterScreen({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;

  @override
  State<FormRegisterScreen> createState() => _FormRegisterScreenState();
}

class _FormRegisterScreenState extends State<FormRegisterScreen> {
  CountryCode _countryCode = CountryCode.fromDialCode('+20');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          controller: widget.nameController,
          hintText: LocaleKeys.full_name_hint.tr(),
          keyboardType: TextInputType.name,
          validator:
              (value) =>
                  value!.isEmpty ? LocaleKeys.full_name_validator.tr() : null,
          prefixIcon: const Icon(Icons.person, color: Colors.white),
        ),
        20.0.height,
        AppTextFormField(
          controller: widget.emailController,
          hintText: LocaleKeys.email_hint.tr(),
          keyboardType: TextInputType.emailAddress,
          validator:
              (value) =>
                  value!.isEmpty ? LocaleKeys.email_validator.tr() : null,
          prefixIcon: const Icon(Icons.email_outlined, color: Colors.white),
        ),
        20.0.height,
        Row(
          children: [
            Expanded(
              child: AppTextFormField(
                controller: widget.phoneController,
                keyboardType: TextInputType.phone,
                hintText: LocaleKeys.phone_hint.tr(),
                validator:
                    (v) => v!.isEmpty ? LocaleKeys.phone_validator.tr() : null,
              ),
            ),
            8.0.width,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: CountryCodePicker(
                initialSelection: _countryCode.code,
                favorite: const ['EG', '+20'],
                textStyle: const TextStyle(color: Colors.white),
                dialogTextStyle: const TextStyle(color: Colors.black),
                showFlagDialog: true,
                onChanged: (code) => setState(() => _countryCode = code),
              ),
            ),
          ],
        ),
        20.0.height,
        AppTextFormField(
          controller: widget.passwordController,
          hintText: LocaleKeys.password_hint.tr(),
          obsecureText: true,
          keyboardType: TextInputType.visiblePassword,
          validator:
              (value) =>
                  value!.isEmpty ? LocaleKeys.password_validator.tr() : null,
        ),
        20.0.height,
        AppTextFormField(
          controller: widget.confirmPasswordController,
          hintText: LocaleKeys.confirm_password_hint.tr(),
          obsecureText: true,
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            if (value!.isEmpty) {
              return LocaleKeys.confirm_password_validator.tr();
            } else if (value != widget.passwordController.text) {
              return LocaleKeys.passwords_not_matching.tr();
            }
            return null;
          },
        ),
      ],
    );
  }
}
