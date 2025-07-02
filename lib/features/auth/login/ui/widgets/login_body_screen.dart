import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/localization/locale_keys.dart';
import 'package:lamsa/core/routing/routes.dart';
import 'package:lamsa/core/widgets/custom_button.dart';
import 'package:lamsa/features/auth/login/ui/widgets/footer_login_screen.dart';
import 'package:lamsa/features/auth/login/ui/widgets/form_login_screen.dart';
import 'package:lamsa/features/auth/login/ui/widgets/header_login_screen.dart';
import 'package:lamsa/features/auth/login/ui/widgets/social_auth_row.dart';

class LoginBodyScreen extends StatefulWidget {
  const LoginBodyScreen({super.key});

  @override
  State<LoginBodyScreen> createState() => _LoginBodyScreenState();
}

class _LoginBodyScreenState extends State<LoginBodyScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: formKey,
          child: AnimationLimiter(
            child: ListView(
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 700),
                delay: const Duration(milliseconds: 200),
                childAnimationBuilder:
                    (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      curve: Curves.easeOut,
                      child: FadeInAnimation(child: widget),
                    ),
                children: [
                  60.0.height,
                  const HeaderLoginScreen(),
                  40.0.height,
                  FormLoginScreen(
                    emailController: emailController,
                    passwordController: passwordController,
                  ),

                  30.0.height,
                  CustomButton(
                    text: LocaleKeys.login.tr(),
                    onPressed: () {
                      // if (formKey.currentState!.validate()) {

                      // }
                      context.pushNamed(Routes.layout);
                    },
                  ),
                  20.0.height,
                  const FooterLoginScreen(),
                  20.0.height,
                  SocialAuthRow(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
