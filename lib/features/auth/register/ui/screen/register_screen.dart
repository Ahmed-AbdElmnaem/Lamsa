import 'package:flutter/material.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/features/auth/register/ui/widgets/register_body_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.mainColor,
      body: const RegisterBodyScreen(),
    );
  }
}
