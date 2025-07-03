import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';
import 'package:lamsa/features/home/ui/data/model/product_model.dart';

import 'product_card.dart';

/// ---------------------------------------------------------------------------
/// ProductGrid
/// ---------------------------------------------------------------------------
/// Responsive 2‑column grid that displays [ProductCard]s.
///
/// * Calculates a safer `childAspectRatio` to avoid overflow.
/// * Accepts a non‑empty list of [Product]s.
class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.products,
    this.title = 'المنتجات',
  });

  final List<ProductModel> products;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    // We need a taller card than 0.75 to fit the image + details safely.
    final childAspectRatio = 0.62; // width / height

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            title,
            style: Styles.font18W600.copyWith(color: ColorManager.mainColor),
          ),
        ),
        16.0.height,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder:
                (_, index) => ProductCard(
                  product: products[index],
                  onTap: () {},
                  onFavoriteToggle: () {},
                ),
          ),
        ),
      ],
    );
  }
}
