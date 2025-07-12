// widgets/product_location_info.dart
import 'package:flutter/material.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';

class ProductLocationInfo extends StatelessWidget {
  final String location;

  const ProductLocationInfo({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('الموقع', style: Styles.font16W600),
        12.0.height,
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorManager.mainColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.location_on, color: ColorManager.mainColor, size: 20),
              12.0.width,
              Expanded(child: Text(location, style: Styles.font14W400)),
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {},
              ),
            ],
          ),
        ),
        24.0.height,
      ],
    );
  }
}
