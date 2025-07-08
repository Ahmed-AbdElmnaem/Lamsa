import 'package:lamsa/features/home/data/model/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProductsByCategory(String categoryId);
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductDetails(String productId);
}
