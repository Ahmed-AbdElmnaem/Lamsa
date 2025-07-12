// widgets/// widgets/product_quantity_selector.dart
import 'package:flutter/material.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';

class ProductQuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;

  const ProductQuantitySelector({
    super.key,
    required this.quantity,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: ColorManager.mainColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'الكمية',
            style: Styles.font16W600.copyWith(color: Colors.black),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove, color: Colors.grey[600]),
                  onPressed: () {
                    if (quantity > 1) onChanged(quantity - 1);
                  },
                ),
                Container(
                  width: 40,
                  alignment: Alignment.center,
                  child: Text(quantity.toString(), style: Styles.font16W600),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: ColorManager.mainColor),
                  onPressed: () => onChanged(quantity + 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
