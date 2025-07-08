import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/routing/routes.dart';
import 'package:lamsa/core/theming/styles.dart';
import 'package:lamsa/features/home/data/model/product_model.dart';
import 'package:lamsa/features/home/ui/widgets/section_header.dart';
import 'package:lamsa/features/product/logic/cubit/product_cubit_cubit.dart';

import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.products,
    this.title = 'المنتجات',
    required this.isHeder,
  });

  final List<ProductModel> products;
  final String title;
  final bool isHeder;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    final childAspectRatio = 0.62;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isHeder)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SectionHeader(
              title: title,
              onMorePressed: () {
                context.pushNamed(Routes.product);
              },
            ),
          ),

        16.0.height,
        BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading)
              return const Center(child: CircularProgressIndicator());
            if (state is ProductError) {
              return Center(
                child: Text(
                  state.message,
                  style: Styles.font16W400.copyWith(color: Colors.red),
                ),
              );
            }
            if (state is ProductLoaded && state.products.isEmpty) {
              return Center(
                child: Text(
                  'لا توجد منتجات',
                  style: Styles.font16W400.copyWith(color: Colors.grey),
                ),
              );
            }
            if (state is ProductLoaded) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: childAspectRatio,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                  ),
                  itemBuilder:
                      (context, index) => ProductCard(
                        product: state.products[index],
                        onTap: () {
                          log('Product tapped: ${state.products[index].name}');
                          context.pushNamed(
                            Routes.productDetails,
                            arguments: state.products[index],
                          );
                        },
                      ),
                ),
              );
            }
            // ---- Fallback (shouldn’t reach) ----
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),
      ],
    );
  }
}
