// widgets/product_action_buttons.dart
import 'package:flutter/material.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/widgets/custom_button.dart';
import 'package:lamsa/features/home/data/model/product_model.dart';

class ProductActionButtons extends StatelessWidget {
  final ProductModel product;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onAddToCart;
  final VoidCallback onBuyNow;

  const ProductActionButtons({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onAddToCart,
    required this.onBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Expanded(
          child: CustomButton(
            height: 52,
            borderRadius: 12,
            backgroundColor: ColorManager.mainColor,
            onPressed: onAddToCart,
            text: 'إضافة للسلة',
            foregroundColor: Colors.white,
            trailing: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CustomButton(
            height: 52,
            borderRadius: 12,
            backgroundColor: Colors.white,
            onPressed: onBuyNow,
            text: 'شراء الان',
          ),
        ),
      ],
    );
  }
}
