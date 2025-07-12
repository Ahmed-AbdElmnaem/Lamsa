import 'package:lamsa/features/home/data/fake/fake_categories.dart';
import 'package:lamsa/features/home/data/model/category_model.dart';
import 'package:lamsa/features/home/data/repo/category_repository.dart';

class FakeCategoryRepository implements CategoryRepository {
  @override
  Future<List<CategoryModel>> getAllCategories() async {
    await Future.delayed(const Duration(seconds: 1));
    return kFakeCategories;
  }
}
