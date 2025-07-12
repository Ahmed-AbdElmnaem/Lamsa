import 'package:flutter/material.dart';
import 'package:lamsa/core/theming/styles.dart';
import 'package:lamsa/features/home/data/model/product_model.dart';

class CartScreenBody extends StatelessWidget {
  const CartScreenBody({
    super.key,
    required this.products,
    required this.quantities,
    required this.subtotal,
  });

  final List<ProductModel> products;
  final List<int> quantities;
  final double subtotal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (_, index) {
                final product = products[index];
                return Container(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.imageUrl.first,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              product.nameStore ?? '',
                              style: Styles.font14W500.copyWith(
                                color: Colors.red,
                              ),
                            ),

                            const SizedBox(height: 4),
                            Text(
                              '${product.price.toStringAsFixed(2)} EGP',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text('الكمية: ${quantities[index]}'),
                          ],
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Handle remove item from cart
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('الإجمالي الفرعي:', style: TextStyle(fontSize: 16)),
              Text('${subtotal.toStringAsFixed(2)} EGP'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('الشحن والضريبة:', style: TextStyle(fontSize: 16)),
              Text('15.00 EGP'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'الإجمالي:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('${(subtotal + 15).toStringAsFixed(2)} EGP'),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('الدفع'),
          ),
        ],
      ),
    );
  }
}
