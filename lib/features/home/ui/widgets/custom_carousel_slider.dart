import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/theming/color_manager.dart';

class CustomCarouselSlider extends StatelessWidget {
  final List<String> imageUrls;
  final void Function(int index)? onTap;
  final bool autoPlay;
  final double aspectRatio;

  const CustomCarouselSlider({
    super.key,
    required this.imageUrls,
    this.onTap,
    required this.autoPlay,
    required this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: imageUrls.length,
      options: CarouselOptions(
        aspectRatio: aspectRatio,
        autoPlay: autoPlay,
        enlargeCenterPage: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.easeInCubic,
        viewportFraction: 0.85,
        scrollDirection: Axis.horizontal,
      ),
      itemBuilder: (context, index, realIndex) {
        final imageUrl = imageUrls[index];

        return GestureDetector(
          onTap: () => onTap?.call(index),
          child: Hero(
            tag: 'image_$index',
            transitionOnUserGestures: true,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0.r),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.mainColor.withOpacity(0.9),
                        blurRadius: 10,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder:
                        (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                    errorWidget:
                        (context, url, error) => const Center(
                          child: Icon(Icons.broken_image, size: 40),
                        ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
