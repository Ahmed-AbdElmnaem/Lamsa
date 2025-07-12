// widgets/product_seller_info.dart
import 'package:flutter/material.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';

class ProductSellerInfo extends StatelessWidget {
  final String name;

  const ProductSellerInfo({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('البائع', style: Styles.font16W600),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorManager.mainColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorManager.mainColor.withOpacity(0.2),
                ),
                child: Icon(Icons.store, color: ColorManager.mainColor),
              ),
              12.0.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Styles.font14W600),
                    4.0.height,
                    Text(
                      'متجر رسمي',
                      style: Styles.font12W400.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {},
              ),
            ],
          ),
        ),
        24.0.height,
      ],
    );
  }
}
