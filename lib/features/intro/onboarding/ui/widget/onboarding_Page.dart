import 'package:flutter/material.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/theming/styles.dart';
import 'package:lamsa/features/intro/onboarding/data/model/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.model, required this.onSkip});

  final OnboardingModel model;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(model.image, fit: BoxFit.cover),
        Container(color: Colors.black.withOpacity(0.35)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: onSkip,
                  child: Text(
                    'تخطي',
                    style: Styles.font18W400.copyWith(color: Colors.white),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                model.title,
                style: Styles.font30W500.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              15.0.height,
              Text(
                model.description,
                style: Styles.font16W400.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ],
    );
  }
}
