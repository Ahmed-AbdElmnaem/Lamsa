import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamsa/core/di/dependency_Injection.dart';
import 'package:lamsa/core/widgets/custom_app_bar.dart';
import 'package:lamsa/features/home/logic/cubit/category_cubit.dart';
import 'package:lamsa/features/home/ui/widgets/home_screen_body.dart';
import 'package:lamsa/features/product/logic/cubit/product_cubit_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final cubit = getIt<ProductCubit>();
            cubit.fetchAllProducts();

            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final cubit = getIt<CategoryCubit>();
            cubit.fetchCategories();
            return cubit;
          },
        ),
      ],

      child: Scaffold(
        appBar: CustomAppBar(onMenuTap: () {}),
        body: HomeScreenBody(),
      ),
    );
  }
}
