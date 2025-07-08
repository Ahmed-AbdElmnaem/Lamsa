import 'package:flutter/material.dart';
import 'package:lamsa/features/home/data/model/product_model.dart';
import 'package:lamsa/features/product/product_details/ui/widgets/product_details_body_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ProductDetailsBodyScreen(product: product));
  }
}
