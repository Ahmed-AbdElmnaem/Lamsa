import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/localization/locale_keys.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';
import 'package:lamsa/core/utils/assets_manager.dart';
import 'package:lamsa/core/widgets/custom_app_bar.dart';
import 'package:lamsa/core/widgets/custom_text_field.dart';
import 'package:lamsa/features/home/data/fake/fake_categories.dart';
import 'package:lamsa/features/home/data/fake/fake_data_artist.dart';
import 'package:lamsa/features/home/data/fake/fake_product_data.dart';
import 'package:lamsa/features/home/ui/widgets/artists_section.dart';
import 'package:lamsa/features/home/ui/widgets/category_section.dart';
import 'package:lamsa/features/home/ui/widgets/custom_carousel_slider.dart';
import 'package:lamsa/features/home/ui/widgets/custom_product_grid.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(onMenuTap: () => Scaffold.of(context).openDrawer()),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.42,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorManager.mainColor,
                    Color(0xFF152E5B),
                    Colors.white,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---- Search Bar ----
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                    child: FadeInDown(
                      duration: const Duration(milliseconds: 500),
                      child: AppTextFormField(
                        hintStyle: Styles.font16W400.copyWith(
                          color: Colors.black54,
                        ),
                        backgroundColor: Colors.grey[200],
                        hintText: LocaleKeys.search_hint.tr(),
                        prefixIcon: Image.asset(AssetsManager.filter),
                        suffixIcon: const Icon(
                          Icons.search,
                          color: ColorManager.mainColor,
                        ),
                        validator:
                            (v) =>
                                (v == null || v.isEmpty)
                                    ? LocaleKeys.search_validator.tr()
                                    : null,
                      ),
                    ),
                  ),
                  // ---- Carousel ----
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: FadeIn(
                          duration: const Duration(milliseconds: 650),
                          child: CustomCarouselSlider(
                            imageUrls: const [
                              'https://m.media-amazon.com/images/I/618ZM9+iexL._UF1000,1000_QL80_.jpg',
                              'https://i.etsystatic.com/14617267/r/il/40951e/5596926607/il_300x300.5596926607_bu2e.jpg',
                              'https://static.desygner.com/virginia/344/bYNBmj5BdF6/d3fd85c6f268c9f6ac89def27513cb0b.jpg',
                              'https://cdn.prod.website-files.com/67336b2139b6b0905c503a6b/67a37491f6fc60593a5ed16e_hair-salon-discount-for-new-clients.jpeg',
                            ],
                            onTap: (idx) => debugPrint('Clicked image $idx'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ===== Categories =====
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            sliver: SliverToBoxAdapter(
              child: SlideInRight(
                duration: const Duration(milliseconds: 500),
                child: CategorySection(
                  onMorePressed: () {},
                  categories: kFakeCategories,
                ),
              ),
            ),
          ),

          // ===== Artists =====
          SliverPadding(
            padding: EdgeInsets.only(bottom: 16.h),
            sliver: SliverToBoxAdapter(
              child: FadeInUp(
                duration: const Duration(milliseconds: 550),
                child: ArtistsSection(artists: kFakeArtists),
              ),
            ),
          ),

          // ===== Products Grid =====
          SliverPadding(
            padding: EdgeInsets.only(bottom: 32.h),
            sliver: SliverToBoxAdapter(
              child: ZoomIn(
                duration: const Duration(milliseconds: 600),
                child: ProductGrid(products: kFakeProducts, isHeder: true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
