import 'package:flutter/material.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BottomControls extends StatelessWidget {
  const BottomControls({
    super.key,
    required this.pageNotifier,
    required this.pageCount,
    required this.controller,
    required this.onFinish,
  });

  final ValueNotifier<int> pageNotifier;
  final int pageCount;
  final PageController controller;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SmoothPageIndicator(
          controller: controller,
          count: pageCount,
          effect: const WormEffect(
            activeDotColor: Colors.white,
            dotColor: Colors.white38,
            dotHeight: 12,
            dotWidth: 12,
          ),
          onDotClicked:
              (index) => controller.animateToPage(
                index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              ),
        ),
        20.0.height,
        ValueListenableBuilder<int>(
          valueListenable: pageNotifier,
          builder: (context, index, _) {
            final isLast = index == pageCount - 1;
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 100,
                ),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                if (isLast) {
                  onFinish();
                } else {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Text(
                isLast ? 'إنهاء' : 'التالي',
                style: Styles.font18W400.copyWith(color: ColorManager.black),
              ),
            );
          },
        ),
      ],
    );
  }
}
