import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/localization/locale_keys.dart';
import 'package:lamsa/core/widgets/custom_button.dart';
import 'package:lamsa/features/auth/register/ui/widgets/footer_register_screen.dart';
import 'package:lamsa/features/auth/register/ui/widgets/form_register_screen.dart';
import 'package:lamsa/features/auth/register/ui/widgets/header_register_screen.dart';

class RegisterBodyScreen extends StatefulWidget {
  const RegisterBodyScreen({super.key});

  @override
  State<RegisterBodyScreen> createState() => _RegisterBodyScreenState();
}

class _RegisterBodyScreenState extends State<RegisterBodyScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: formKey,
          child: AnimatedBuilder(
            animation: _controller,
            builder:
                (context, child) => Opacity(
                  opacity: _fadeAnimation.value,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: ListView(
                      children: [
                        60.0.height,
                        const HeaderRegisterScreen(),
                        40.0.height,
                        FormRegisterScreen(
                          confirmPasswordController: confirmPasswordController,
                          emailController: emailController,
                          nameController: nameController,
                          passwordController: passwordController,
                        ),

                        30.0.height,
                        CustomButton(
                          text: LocaleKeys.create_account.tr(),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // sign up logic
                            }
                          },
                        ),
                        20.0.height,
                        const FooterRegisterScreen(),
                        20.0.height,
                      ],
                    ),
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
