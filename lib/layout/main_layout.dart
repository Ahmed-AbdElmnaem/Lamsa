import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/widgets/scroll_aware_nav_bar.dart';
import 'package:lamsa/features/home/ui/screen/home_screen.dart';

import '../core/theming/color_manager.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollAwareScaffold(
      labelColor: Colors.white,
      navHeight: 30,
      navWidthFactor: 0.9,
      innerPadding: EdgeInsets.only(bottom: 12.h, left: 9.w, right: 9.w),
      navMargin: EdgeInsets.all(12.w),

      navColor: ColorManager.mainColor,
      pages: const [HomeScreen(), HomeScreen(), HomeScreen(), HomeScreen()],
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home, color: Colors.white),
          label: 'الرئيسية',
        ),
        NavigationDestination(
          icon: Icon(Icons.list, color: Colors.white),
          label: 'الطلبات',
        ),
        NavigationDestination(
          icon: Icon(Icons.person, color: Colors.white),
          label: 'الحساب',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings, color: Colors.white),
          label: 'الاعدادات',
        ),
      ],
    );
  }
}
