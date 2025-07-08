part of 'product_cubit_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductCubitInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final String? selectedId;

  const ProductLoaded({required this.products, required this.selectedId});

  @override
  List<Object> get props => [products, selectedId ?? ''];
}

class ProductError extends ProductState {
  final String message;
  const ProductError({required this.message});

  @override
  List<Object> get props => [message];
}
