import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamsa/core/di/dependency_Injection.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';
import 'package:lamsa/features/home/data/fake/fake_categories.dart';
import 'package:lamsa/features/product/logic/cubit/product_cubit_cubit.dart';
import 'package:lamsa/features/product/ui/widget/prodcut_screen_body.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, this.categoryId});
  final String? categoryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProductCubit>()..init(categoryId),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          centerTitle: true,
          title: Text(
            'المنتجات',
            style: Styles.font24W600.copyWith(color: ColorManager.mainColor),
          ),
        ),
        body: ProdcutScreenBody(categories: kFakeCategories),
      ),
    );
  }
}
