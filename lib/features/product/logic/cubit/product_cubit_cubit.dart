import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lamsa/features/home/data/model/product_model.dart';
import 'package:lamsa/features/product/data/repo/product_repository.dart';

part 'product_cubit_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _repo;
  String? _selectedId;

  ProductCubit(this._repo) : super(ProductCubitInitial());

  void init(String? initialId) {
    _selectedId = initialId;
    _fetch();
  }

  void selectCategory(String? id) {
    if (_selectedId == id) return;
    _selectedId = id;
    _fetch();
  }

  Future<void> _fetch() async {
    emit(ProductLoading());
    try {
      final products =
          _selectedId == null
              ? await _repo.getAllProducts()
              : await _repo.getProductsByCategory(_selectedId!);
      emit(ProductLoaded(products: products, selectedId: _selectedId));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> fetchProducts(String categoryId) async {
    _selectedId = categoryId;
    _fetch();
  }

  Future<void> fetchAllProducts() async {
    _selectedId = null;
    _fetch();
  }
}
