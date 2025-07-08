import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/di/dependency_Injection.dart';
import 'package:lamsa/core/helpers/observe.dart';
import 'package:lamsa/core/routing/app_router.dart';
import 'package:lamsa/lamsa.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setup();

  Bloc.observer = MyBlocObserver();

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (_, __) => EasyLocalization(
            supportedLocales: const [Locale('en'), Locale('ar')],
            path: 'assets/translations',
            fallbackLocale: const Locale('en'),
            child: Lamsa(appRouter: AppRouter()),
          ),
    ),
  );
}
