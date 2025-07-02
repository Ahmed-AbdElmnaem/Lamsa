import 'package:flutter/material.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/features/auth/login/ui/widgets/login_body_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.mainColor,
      body: const LoginBodyScreen(),
    );
  }
}
