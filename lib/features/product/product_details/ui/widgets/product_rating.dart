// widgets/product_rating.dart
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';

class ProductRating extends StatelessWidget {
  final double rating;
  const ProductRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RatingBarIndicator(
                    rating: rating,
                    itemBuilder:
                        (context, index) =>
                            const Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 16,
                    direction: Axis.horizontal,
                  ),
                  8.0.width,
                  Text(
                    rating.toStringAsFixed(1),
                    style: Styles.font14W600.copyWith(color: Colors.amber[800]),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            TextButton(
              onPressed: () {},
              child: Text(
                '$rating تقييمات',
                style: Styles.font14W500.copyWith(
                  color: ColorManager.mainColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),

        16.0.height,
      ],
    );
  }
}
