import 'package:lamsa/features/home/data/model/category_model.dart';

abstract class CategoryRepository {
  /// Fetches all categories.
  Future<List<CategoryModel>> getAllCategories();

  /// Fetches a specific category by its ID.
}
