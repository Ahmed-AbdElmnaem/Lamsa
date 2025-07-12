import 'package:flutter/material.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/features/home/data/model/product_model.dart';
import 'package:lamsa/features/product/product_details/ui/widgets/custom_carousel_slider_product.dart';
import 'package:lamsa/features/product/product_details/ui/widgets/product_details_content.dart';

class ProductDetailsBodyScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsBodyScreen({super.key, required this.product});

  @override
  State<ProductDetailsBodyScreen> createState() =>
      _ProductDetailsBodyScreenState();
}

class _ProductDetailsBodyScreenState extends State<ProductDetailsBodyScreen> {
  late String selectedSize;
  late Color selectedColor;
  bool _isFavorite = false;
  final ScrollController _scrollController = ScrollController();
  final double _bottomSheetHeight = 0.5; // Initial height (50% of screen)

  @override
  void initState() {
    super.initState();
    selectedSize = widget.product.sizes?.first ?? '';
    selectedColor = widget.product.colors?.first ?? Colors.black;
    _isFavorite = widget.product.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      // Add your favorite logic here
    });
  }

  void showImagePreview(String imageUrl, int index) {
    showDialog(
      context: context,
      builder:
          (_) => Dialog(
            child: Hero(
              tag: 'product_image_${widget.product.id}_$index',
              child: Image.network(imageUrl),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Main content (image gallery)
            Positioned.fill(
              child: SizedBox(
                height: size.height * 0.6, // Explicit height
                child: CustomCarouselSliderProductDetails(
                  product: widget.product,
                  productId: widget.product.id,
                  imageUrls: widget.product.imageUrl,
                  autoPlay: true,
                  aspectRatio: 1.0,
                  showThumbnails: true,
                  showZoomOption: true,
                  showFavoriteOption: true,
                  showShareOption: true,
                  showVideoIndicator: false,
                  activeIndicatorColor: ColorManager.mainColor,
                  indicatorColor: Colors.grey,
                  appBarIconsColor: Colors.white,
                  appBarBackgroundColor: ColorManager.mainColor.withOpacity(
                    0.3,
                  ),
                ),
              ),
            ),

            ProductDetailsContent(
              product: widget.product,
              onSizeSelected: (size) {
                setState(() => selectedSize = size);
              },
              onColorSelected: (color) {
                setState(() => selectedColor = color);
              },
            ),

            // App bar
          ],
        ),
      ),
    );
  }
}
