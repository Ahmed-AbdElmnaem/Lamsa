import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/widgets/scroll_aware_nav_bar.dart';
import 'package:lamsa/features/home/ui/screen/home_screen.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollAwareNavScaffold(
      barHeight: 50.h,
      navColor: ColorManager.mainColor,
      pages: const [HomeScreen(), HomeScreen(), HomeScreen(), HomeScreen()],
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'الرئيسية'),
        NavigationDestination(icon: Icon(Icons.list_alt), label: 'الطلبات'),
        NavigationDestination(icon: Icon(Icons.person), label: 'الحساب'),
        NavigationDestination(icon: Icon(Icons.settings), label: 'الإعدادات'),
      ],
    );
  }
}
