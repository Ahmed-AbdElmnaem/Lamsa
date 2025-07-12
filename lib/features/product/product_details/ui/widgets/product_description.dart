// widgets/product_description.dart
import 'package:flutter/material.dart';
import 'package:lamsa/core/theming/styles.dart';

class ProductDescription extends StatelessWidget {
  final String description;
  final bool isExpanded;
  final VoidCallback onToggle;

  const ProductDescription({
    super.key,
    required this.description,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final showToggle = description.length > 150;
    final displayedText =
        isExpanded || !showToggle
            ? description
            : '${description.substring(0, 150)}...';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('وصف المنتج', style: Styles.font16W600),
        const SizedBox(height: 8),
        Text(displayedText, style: Styles.font14W400.copyWith(height: 1.6)),
        if (showToggle)
          TextButton(
            onPressed: onToggle,
            child: Text(
              isExpanded ? 'عرض أقل' : 'عرض المزيد',
              style: Styles.font14W500.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        const SizedBox(height: 24),
      ],
    );
  }
}
