import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({
    super.key,
    this.onTap,
    this.name,
    required this.image,
    required this.specialty,
    required this.rating,
  });
  final String? name;
  final String image;
  final String specialty;
  final double rating;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: 120.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorManager.mainColor,
              ColorManager.mainColor.withOpacity(0.85),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28.r,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: CachedNetworkImage(
                  width: 56.w,
                  height: 56.w,
                  imageUrl: image,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                  errorWidget:
                      (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
            12.0.height,
            Text(
              name ?? '',
              style: Styles.font14W500.copyWith(
                color: Colors.white,
                height: 1.1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            4.0.height,
            Text(
              specialty,
              style: Styles.font12W400.copyWith(
                color: Colors.white70,
                height: 1.1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            4.0.height,
            ...[4.0.height, _Stars(rating: rating)],
          ],
        ),
      ),
    );
  }
}

/// Simple static star‑rating row.
class _Stars extends StatelessWidget {
  const _Stars({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    final hasHalf = (rating - fullStars) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, size: 12, color: Colors.amber);
        } else if (index == fullStars && hasHalf) {
          return const Icon(Icons.star_half, size: 12, color: Colors.amber);
        } else {
          return const Icon(Icons.star_border, size: 12, color: Colors.amber);
        }
      }),
    );
  }
}
