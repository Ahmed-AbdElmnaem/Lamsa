import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/localization/locale_keys.dart';
import 'package:lamsa/core/routing/routes.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';
import 'package:lamsa/core/utils/assets_manager.dart';
import 'package:lamsa/core/widgets/custom_text_field.dart';
import 'package:lamsa/features/home/data/model/category_model.dart';
import 'package:lamsa/features/home/ui/widgets/product_card.dart';
import 'package:lamsa/features/product/logic/cubit/product_cubit_cubit.dart';
import 'package:lamsa/features/product/ui/widget/category_section_name.dart';

class ProdcutScreenBody extends StatelessWidget {
  const ProdcutScreenBody({super.key, required this.categories});

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: AppTextFormField(
                hintStyle: Styles.font16W400.copyWith(color: Colors.black54),
                backgroundColor: Colors.grey[200],
                hintText: LocaleKeys.search_hint.tr(),
                prefixIcon: GestureDetector(
                  onTap: () {},
                  child: Image.asset(AssetsManager.filter),
                ),
                suffixIcon: const Icon(
                  Icons.search,
                  color: ColorManager.mainColor,
                ),
                validator:
                    (v) =>
                        (v == null || v.isEmpty)
                            ? LocaleKeys.search_validator.tr()
                            : null,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: 20.0.height),
        SliverToBoxAdapter(
          child: BlocBuilder<ProductCubit, ProductState>(
            buildWhen:
                (p, n) =>
                    n is ProductLoaded &&
                    (p is! ProductLoaded || n.selectedId != p.selectedId),
            builder: (context, state) {
              final selectedId =
                  state is ProductLoaded ? state.selectedId : null;
              return CategorySectionName(
                categories: categories,
                selectedId: selectedId,
                onTap: context.read<ProductCubit>().selectCategory,
              );
            },
          ),
        ),
        SliverToBoxAdapter(child: 50.0.height),
        BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (state is ProductError) {
              return SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    state.message,
                    style: Styles.font16W500.copyWith(color: Colors.red),
                  ),
                ),
              );
            }
            if (state is ProductLoaded) {
              if (state.products.isEmpty) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text('لا يوجد منتجات حاليًا')),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => SlideInUp(
                      duration: Duration(milliseconds: 300 + (i % 6) * 50),
                      child: ProductCard(
                        product: state.products[i],
                        onTap:
                            () => context.pushNamed(
                              Routes.productDetails,
                              arguments: state.products[i],
                            ),
                      ),
                    ),
                    childCount: state.products.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.62,
                  ),
                ),
              );
            }
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),

        const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
      ],
    );
  }
}
