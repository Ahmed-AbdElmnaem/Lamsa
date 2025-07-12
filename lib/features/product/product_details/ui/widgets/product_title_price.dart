// widgets/product_title_price.dart
import 'package:flutter/material.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';
import 'package:lamsa/features/home/data/model/product_model.dart';

class ProductTitlePrice extends StatelessWidget {
  final ProductModel product;

  const ProductTitlePrice({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // اسم المنتج
        Text(
          product.name,
          style: Styles.font22W800.copyWith(
            fontWeight: FontWeight.bold,
            height: 1.4,
            fontSize: 22,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        12.0.height,

        // السعر والعروض
        Row(
          children: [
            // السعر الحالي
            Text(
              '${product.price.toStringAsFixed(2)} ج.م',
              style: Styles.font20W700.copyWith(color: ColorManager.mainColor),
            ),

            if (product.hasDiscount) ...[
              10.0.width,

              // السعر القديم
              Text(
                '${product.oldPrice!.toStringAsFixed(2)} ج.م',
                style: Styles.font14W500.copyWith(
                  color: Colors.grey[500],
                  decoration: TextDecoration.lineThrough,
                ),
              ),

              10.0.width,

              // نسبة الخصم
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'خصم ${(((product.oldPrice! - product.price) / product.oldPrice!) * 100).toStringAsFixed(0)}%',
                  style: Styles.font13W600.copyWith(color: Colors.red),
                ),
              ),
            ],
          ],
        ),
        20.0.height,
      ],
    );
  }
}
