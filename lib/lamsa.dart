import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lamsa/core/routing/app_router.dart';
import 'package:lamsa/core/routing/routes.dart';

class Lamsa extends StatelessWidget {
  const Lamsa({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        fontFamily: 'Amiri',
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      onGenerateRoute: appRouter.onGenerateRoute,
      initialRoute: Routes.splash,
    );
  }
}
