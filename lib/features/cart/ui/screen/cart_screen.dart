import 'package:flutter/material.dart';
import 'package:lamsa/features/cart/ui/widgets/cart_screen_body.dart';
import 'package:lamsa/features/home/data/model/product_model.dart';

class CartScreen extends StatelessWidget {
  final List<ProductModel> products;
  final List<int> quantities;
  const CartScreen({
    super.key,
    required this.products,
    required this.quantities,
  });

  @override
  Widget build(BuildContext context) {
    double subtotal = 0;
    for (int i = 0; i < products.length; i++) {
      subtotal += products[i].price * quantities[i];
    }

    return Scaffold(
      appBar: AppBar(title: const Text('سلة المشتريات')),
      body: CartScreenBody(
        products: products,
        quantities: quantities,
        subtotal: subtotal,
      ),
    );
  }
}
