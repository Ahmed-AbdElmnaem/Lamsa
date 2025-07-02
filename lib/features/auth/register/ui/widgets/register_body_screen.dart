import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/localization/locale_keys.dart';
import 'package:lamsa/core/widgets/custom_button.dart';
import 'package:lamsa/features/auth/login/ui/widgets/social_auth_row.dart';
import 'package:lamsa/features/auth/register/ui/widgets/footer_register_screen.dart';
import 'package:lamsa/features/auth/register/ui/widgets/form_register_screen.dart';
import 'package:lamsa/features/auth/register/ui/widgets/header_register_screen.dart';

class RegisterBodyScreen extends StatefulWidget {
  const RegisterBodyScreen({super.key});

  @override
  @override
  State<RegisterBodyScreen> createState() => _RegisterBodyScreenState();
}

class _RegisterBodyScreenState extends State<RegisterBodyScreen>
    with SingleTickerProviderStateMixin {
  // Animation controller & tweens
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 700),
    vsync: this,
  )..forward();

  late final Animation<Offset> _slideAnimation = Tween<Offset>(
    begin: const Offset(0, 0.15),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

  late final Animation<double> _fadeAnimation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );

  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  /*************  ✨ Windsurf Command ⭐  *************/
  /// Disposes the resources used by the `_RegisterBodyScreenState` including
  /// the animation controller and text controllers to free up memory.
  /// *****  ebfd6055-0177-4521-a75c-e1ddb2985e3c  ******
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: AnimatedBuilder(
            animation: _controller,
            builder:
                (context, child) => Opacity(
                  opacity: _fadeAnimation.value,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: ListView(
                      children: [
                        const HeaderRegisterScreen(),
                        40.0.height,
                        FormRegisterScreen(
                          phoneController: _phoneController,
                          confirmPasswordController: _confirmPasswordController,
                          emailController: _emailController,
                          nameController: _nameController,
                          passwordController: _passwordController,
                        ),

                        40.0.height,
                        CustomButton(
                          text: LocaleKeys.create_account.tr(),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // sign up logic
                            }
                          },
                        ),
                        20.0.height,
                        const FooterRegisterScreen(),
                        const SocialAuthRow(),
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
