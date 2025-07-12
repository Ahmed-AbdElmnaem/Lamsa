import 'package:get_it/get_it.dart';
import 'package:lamsa/features/home/data/repo/category_repository.dart';
import 'package:lamsa/features/home/data/repo/fake_category_repository.dart';
import 'package:lamsa/features/home/logic/cubit/category_cubit.dart';
import 'package:lamsa/features/product/data/repo/fake_product_repository.dart';
import 'package:lamsa/features/product/data/repo/product_repository.dart';
import 'package:lamsa/features/product/logic/cubit/product_cubit_cubit.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<ProductRepository>(() => FakeProductRepository());

  getIt.registerFactory(() => ProductCubit(getIt<ProductRepository>()));

  getIt.registerLazySingleton<CategoryRepository>(
    () => FakeCategoryRepository(),
  );

  getIt.registerFactory(() => CategoryCubit(getIt<CategoryRepository>()));
}
