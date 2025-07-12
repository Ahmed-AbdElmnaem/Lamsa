import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/localization/locale_keys.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';
import 'package:lamsa/core/utils/assets_manager.dart';
import 'package:lamsa/core/widgets/custom_text_field.dart';
import 'package:lamsa/features/home/ui/widgets/custom_carousel_slider.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path =
        Path()
          ..lineTo(0, size.height - 40)
          ..quadraticBezierTo(
            size.width * 0.5,
            size.height,
            size.width,
            size.height - 40,
          )
          ..lineTo(size.width, 0)
          ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});
  @override
  Widget build(BuildContext context) {
    final headerHeight = MediaQuery.of(context).size.height * .46;

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 300,
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  tileMode: TileMode.clamp,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white10],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _GlassSearchBar(),
                  20.0.height,
                  const _HeroCarousel(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassSearchBar extends StatelessWidget {
  const _GlassSearchBar();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: AppTextFormField(
          backgroundColor: ColorManager.mainColor.withOpacity(0.2),
          border: InputBorder.none,
          hintStyle: Styles.font16W400.copyWith(color: ColorManager.mainColor),
          hintText: LocaleKeys.search_hint.tr(),
          prefixIcon: Image.asset(
            AssetsManager.filter,
            color: ColorManager.mainColor,
          ),
          suffixIcon: const Icon(Icons.search, color: ColorManager.mainColor),
          validator:
              (v) =>
                  (v == null || v.isEmpty)
                      ? LocaleKeys.search_validator.tr()
                      : null,
        ),
      ),
    );
  }
}

class _HeroCarousel extends StatelessWidget {
  const _HeroCarousel();

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 650),
      child: CustomCarouselSlider(
        aspectRatio: 14 / 7,
        autoPlay: true,
        imageUrls: const [
          'https://m.media-amazon.com/images/I/618ZM9+iexL._UF1000,1000_QL80_.jpg',
          'https://i.etsystatic.com/14617267/r/il/40951e/5596926607/il_300x300.5596926607_bu2e.jpg',
          'https://static.desygner.com/virginia/344/bYNBmj5BdF6/d3fd85c6f268c9f6ac89def27513cb0b.jpg',
          'https://cdn.prod.website-files.com/67336b2139b6b0905c503a6b/67a37491f6fc60593a5ed16e_hair-salon-discount-for-new-clients.jpeg',
        ],
        // Optional: adjust viewportFraction/enlargeCenterPage inside CustomCarouselSlider if needed.
        onTap: (idx) => debugPrint('Clicked image $idx'),
      ),
    );
  }
}
