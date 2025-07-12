import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lamsa/features/home/data/model/category_model.dart';
import 'package:lamsa/features/home/data/repo/category_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this._repo) : super(CategoryInitial());
  final CategoryRepository _repo;

  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await _repo.getAllCategories();
      emit(CategoryLoaded(categories: categories));
    } catch (e) {
      emit(CategoryError(message: e.toString()));
    }
  }
}
