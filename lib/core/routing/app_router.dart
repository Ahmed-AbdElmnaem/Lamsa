import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/theming/styles.dart';
import 'package:lamsa/core/utils/assets_manager.dart';
import 'package:lamsa/features/auth/login/ui/screen/login_screen.dart';
import 'package:lamsa/features/auth/register/ui/screen/register_screen.dart';
import 'package:lamsa/features/home/ui/screen/home_screen.dart';
import 'package:lamsa/features/intro/onboarding/ui/screen/onboarding_screen.dart';
import 'package:lamsa/features/intro/splash/splash_screen.dart';

import 'routes.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      // case Routes.layout:
      //   return MaterialPageRoute(builder: (_) => const MainLayout());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Center(
                      child: Text(
                        "No Route Found pless refresh app",
                        style: Styles.font24W600,
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        AssetsManager.noRoute,
                        height: 200.h,
                        width: 200.w,
                      ),
                    ),
                  ],
                ),
              ),
        );
    }
  }
}
