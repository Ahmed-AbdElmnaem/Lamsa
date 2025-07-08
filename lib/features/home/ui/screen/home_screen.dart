import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamsa/core/di/dependency_Injection.dart';
import 'package:lamsa/features/home/ui/widgets/home_screen_body.dart';
import 'package:lamsa/features/product/logic/cubit/product_cubit_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<ProductCubit>();
        cubit.fetchAllProducts();

        return cubit;
      },
      child: HomeScreenBody(),
    );
  }
}
