import 'package:flutter/material.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/theming/styles.dart';

class ProductHighlights extends StatelessWidget {
  final List<String> highlights;

  const ProductHighlights({super.key, required this.highlights});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('مميزات المنتج', style: Styles.font16W600),
        16.0.height,
        ...highlights.map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle, size: 16, color: Colors.green),
                8.0.width,
                Expanded(child: Text(item, style: Styles.font14W400)),
              ],
            ),
          ),
        ),
        24.0.height,
      ],
    );
  }
}
