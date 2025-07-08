import 'package:flutter/material.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';
import 'package:lamsa/core/widgets/custom_button.dart';
import 'package:lamsa/features/home/data/model/product_model.dart';

import 'color_selector.dart';
import 'size_selector.dart';

class ProductDetailsContent extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsContent({super.key, required this.product});

  @override
  State<ProductDetailsContent> createState() => _ProductDetailsContentState();
}

class _ProductDetailsContentState extends State<ProductDetailsContent> {
  late String selectedSize;
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.product.sizes?.first ?? '';
    selectedColor = widget.product.colors?.first ?? Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.product.nameStore != null)
                        Row(
                          children: [
                            const Icon(
                              Icons.store,
                              size: 16,
                              color: Colors.grey,
                            ),
                            4.0.width,
                            Text(
                              widget.product.nameStore!,
                              style: Styles.font18W400.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      if (widget.product.rating != null)
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            4.0.width,
                            Text(
                              widget.product.rating!.toStringAsFixed(1),
                              style: Styles.font16W500.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  8.0.height,
                  Expanded(
                    child: Text(
                      widget.product.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  16.0.height,
                  Row(
                    children: [
                      if (widget.product.hasDiscount)
                        Text(
                          '${widget.product.oldPrice!.toStringAsFixed(2)} ج.م',
                          style: Styles.font18W600.copyWith(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      if (widget.product.hasDiscount) 8.0.width,
                      Text(
                        '${widget.product.price.toStringAsFixed(2)} ج.م',
                        style: Styles.font20W600.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  16.0.height,

                  if (widget.product.colors != null &&
                      widget.product.colors!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('اللون:', style: Styles.font18W600),
                        8.0.height,
                        ColorSelector(
                          colors: widget.product.colors!,
                          selectedColor: selectedColor,
                          onColorSelected: (color) {
                            setState(() => selectedColor = color);
                          },
                        ),
                      ],
                    ),

                  20.0.height,
                  if (widget.product.sizes != null &&
                      widget.product.sizes!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('المقاس:', style: Styles.font18W600),
                        8.0.height,
                        SizeSelector(
                          sizes: widget.product.sizes!,
                          selectedSize: selectedSize,
                          onSizeSelected: (size) {
                            setState(() => selectedSize = size);
                          },
                        ),
                      ],
                    ),
                  20.0.height,

                  if (widget.product.description != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('الوصف:', style: Styles.font18W600),
                        8.0.height,
                        Text(
                          widget.product.description!,
                          style: Styles.font16W400,
                        ),
                      ],
                    ),

                  20.0.height,

                  if (widget.product.location != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('الموقع:', style: Styles.font18W600),
                        8.0.height,
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.grey,
                            ),
                            4.0.width,
                            Expanded(
                              child: Text(
                                widget.product.location!,
                                style: Styles.font16W400,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  20.0.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomButton(
                          widthBorder: 1,
                          colorBorder: Colors.black,
                          backgroundColor: ColorManager.white,
                          onPressed: () {},
                          text: ' شراء الان',
                          foregroundColor: ColorManager.mainColor,
                        ),
                      ),
                      10.0.width,
                      Expanded(
                        child: CustomButton(
                          trailing: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                          ),
                          backgroundColor: ColorManager.mainColor,
                          onPressed: () {},
                          text: 'اضافة الى السلة',
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
