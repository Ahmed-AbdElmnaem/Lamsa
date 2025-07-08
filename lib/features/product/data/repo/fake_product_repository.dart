import 'package:lamsa/features/home/data/fake/fake_product_data.dart';
import 'package:lamsa/features/home/data/model/product_model.dart';

import 'product_repository.dart';

class FakeProductRepository implements ProductRepository {
  @override
  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return kFakeProducts.where((p) => p.categoryId == categoryId).toList();
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return kFakeProducts;
  }

  @override
  Future<ProductModel> getProductDetails(String productId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final product = kFakeProducts.firstWhere(
      (p) => p.id == productId,
      orElse: () => throw Exception('المنتج غير موجود'),
    );
    return product;
  }
}
