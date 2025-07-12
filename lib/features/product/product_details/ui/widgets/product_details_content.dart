import 'package:flutter/material.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/features/home/data/model/product_model.dart';
import 'package:lamsa/features/product/product_details/ui/widgets/color_selector.dart';
import 'package:lamsa/features/product/product_details/ui/widgets/product_action_buttons.dart';
import 'package:lamsa/features/product/product_details/ui/widgets/product_description.dart';
import 'package:lamsa/features/product/product_details/ui/widgets/product_highlights.dart';
import 'package:lamsa/features/product/product_details/ui/widgets/product_location_info.dart';
import 'package:lamsa/features/product/product_details/ui/widgets/product_quantity_selector.dart';
import 'package:lamsa/features/product/product_details/ui/widgets/product_rating.dart';
import 'package:lamsa/features/product/product_details/ui/widgets/product_seller_info.dart';
import 'package:lamsa/features/product/product_details/ui/widgets/product_title_price.dart';
import 'package:lamsa/features/product/product_details/ui/widgets/size_selector.dart';

class ProductDetailsContent extends StatefulWidget {
  final ProductModel product;
  final Function(int)? onImageSelected;
  final Function(String)? onSizeSelected;
  final Function(Color)? onColorSelected;

  const ProductDetailsContent({
    super.key,
    required this.product,
    this.onImageSelected,
    this.onSizeSelected,
    this.onColorSelected,
  });

  @override
  State<ProductDetailsContent> createState() => _ProductDetailsContentState();
}

class _ProductDetailsContentState extends State<ProductDetailsContent> {
  late String selectedSize;
  late Color selectedColor;
  int quantity = 1;
  bool _isExpanded = false;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.product.sizes?.first ?? '';
    selectedColor = widget.product.colors?.first ?? Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductTitlePrice(product: product),
          if (product.rating != null) ProductRating(rating: product.rating!),
          if (product.colors?.isNotEmpty ?? false)
            ProductColorSelector(
              colors: product.colors!,
              selectedColor: selectedColor,
              onSelect: (color) {
                setState(() => selectedColor = color);
                widget.onColorSelected?.call(color);
              },
            ),
          if (product.sizes?.isNotEmpty ?? false)
            ProductSizeSelector(
              sizes: product.sizes!,
              selectedSize: selectedSize,
              onSelect: (size) {
                setState(() => selectedSize = size);
                widget.onSizeSelected?.call(size);
              },
            ),
          ProductQuantitySelector(
            quantity: quantity,
            onChanged: (val) => setState(() => quantity = val),
          ),
          10.0.height,
          if (product.description != null)
            ProductDescription(
              description: product.description!,
              isExpanded: _isExpanded,
              onToggle: () => setState(() => _isExpanded = !_isExpanded),
            ),
          if (product.highlights != null)
            ProductHighlights(highlights: product.highlights!),
          if (product.nameStore != null)
            ProductSellerInfo(name: product.nameStore!),
          if (product.location != null)
            ProductLocationInfo(location: product.location!),
          ProductActionButtons(
            product: product,
            isFavorite: _isFavorite,
            onFavoriteToggle: () => setState(() => _isFavorite = !_isFavorite),
            onAddToCart: () {},
            onBuyNow: () {},
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
