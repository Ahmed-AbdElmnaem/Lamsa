import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';
import 'package:lamsa/features/home/data/model/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onFavoriteToggle,
    this.heroTag,
    this.width,
  });

  final ProductModel product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final Object? heroTag;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        height: 250.h,
        width: width ?? 160.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: heroTag ?? product.id,
                      child: CachedNetworkImage(
                        imageUrl:
                            product.imageUrl.isNotEmpty
                                ? product.imageUrl.first
                                : 'https://via.placeholder.com/150',
                        fit: BoxFit.cover,
                        placeholder:
                            (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        errorWidget:
                            (context, url, error) =>
                                const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                    Positioned(
                      top: 6.w,
                      right: 6.w,
                      child: Material(
                        color: Colors.black45.withOpacity(0.25),
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: onFavoriteToggle,
                          customBorder: const CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(4.w),
                            child: Icon(
                              product.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 18.sp,
                              color:
                                  product.isFavorite
                                      ? Colors.redAccent
                                      : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Discount badge
                    if (product.hasDiscount)
                      Positioned(
                        top: 6.w,
                        left: 6.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            '-${product.discountPerc.toStringAsFixed(0)}%',
                            style: Styles.font10W500.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // ------------------- DETAILS ------------------- //
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Styles.font14W500,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.0.height,
                  Row(
                    children: [
                      Text(
                        '\u202B${product.price.toStringAsFixed(0)}\u200F EGP',
                        style: Styles.font14W600.copyWith(
                          color: ColorManager.mainColor,
                        ),
                      ),
                      if (product.hasDiscount) ...[
                        6.0.width,
                        Text(
                          '\u202B${product.oldPrice!.toStringAsFixed(0)}\u200F',
                          style: Styles.font12W400.copyWith(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (product.rating != null) ...[
                    6.0.height,
                    _Stars(rating: product.rating!),
                  ],
                  if (product.description != null) ...[
                    4.0.height,
                    Text(
                      product.description!,
                      style: Styles.font10W400.copyWith(color: Colors.black54),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// INTERNAL: stars row
// ---------------------------------------------------------------------------
class _Stars extends StatelessWidget {
  const _Stars({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    final full = rating.floor();
    final half = (rating - full) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < full) {
          return const Icon(Icons.star, size: 12, color: Colors.amber);
        } else if (index == full && half) {
          return const Icon(Icons.star_half, size: 12, color: Colors.amber);
        } else {
          return const Icon(Icons.star_border, size: 12, color: Colors.amber);
        }
      }),
    );
  }
}
