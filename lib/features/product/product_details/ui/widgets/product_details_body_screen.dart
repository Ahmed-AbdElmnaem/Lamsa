import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lamsa/features/home/data/model/product_model.dart';
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: widget.product.id.hashCode,
                      child: CachedNetworkImage(
                        imageUrl: widget.product.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  actions: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade300,
                            ),
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            child: IconButton(
                              icon: Icon(
                                _isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: _isFavorite ? Colors.red : Colors.white,
                              ),
                              onPressed: _toggleFavorite,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (widget.product.hasDiscount)
                      Positioned(
                        bottom: 16,
                        top: 16,
                        left: 20,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${widget.product.discountPerc.toStringAsFixed(0)}% OFF',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SliverToBoxAdapter(child: SizedBox(height: 350)),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 500),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ProductDetailsContent(product: widget.product),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
