import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/features/home/data/fake/fake_categories.dart';
import 'package:lamsa/features/home/data/fake/fake_data_artist.dart';
import 'package:lamsa/features/home/data/fake/fake_product_data.dart';
import 'package:lamsa/features/home/ui/widgets/artists_section.dart';
import 'package:lamsa/features/home/ui/widgets/category_section.dart';
import 'package:lamsa/features/home/ui/widgets/custom_product_grid.dart';
import 'package:lamsa/features/home/ui/widgets/header_section.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        HeaderSection(),

        SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 7.h),
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
    );
  }
}
