import 'package:flutter/material.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/local_storage/secure_storage.dart';
import 'package:lamsa/core/routing/routes.dart';
import 'package:lamsa/features/intro/onboarding/data/model/onboarding_model.dart';
import 'package:lamsa/features/intro/onboarding/ui/widget/bottom_controls.dart';
import 'package:lamsa/features/intro/onboarding/ui/widget/onboarding_Page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  final ValueNotifier<int> _pageNotifier = ValueNotifier<int>(0);

  List<OnboardingModel> get _pages => OnboardingModel.onboardingList;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pageNotifier.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    await SecureCache.saveBool(key: 'onBoarding', value: true);
    if (!mounted) return;
    context.pushNamedAndRemoveUntil(Routes.login, predicate: (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (i) => _pageNotifier.value = i,
              itemBuilder:
                  (context, i) => OnboardingPage(
                    model: _pages[i],
                    onSkip: _finishOnboarding,
                  ),
            ),
            Positioned(
              bottom: 40,
              left: 24,
              right: 24,
              child: BottomControls(
                pageNotifier: _pageNotifier,
                pageCount: _pages.length,
                controller: _pageController,
                onFinish: _finishOnboarding,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
