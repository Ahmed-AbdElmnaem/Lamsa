import 'dart:ui';

class ProductModel {
  const ProductModel({
    required this.categoryId,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    this.description,
    this.rating,
    this.isFavorite = false,
    this.colors,
    this.sizes,
    this.specialty,
    this.location,
    this.nameStore,
  });

  final String id;
  final String categoryId; // Optional category ID for product categorization
  final String name;
  final String imageUrl;
  final double price;
  final double? oldPrice;
  final String? description;
  final double? rating;
  final bool isFavorite;
  final List<Color>? colors;
  final List<String>? sizes;
  final String? specialty;
  final String? location;
  final String? nameStore;

  bool get hasDiscount => oldPrice != null && oldPrice! > price;
  double get discountPerc =>
      hasDiscount ? ((oldPrice! - price) / oldPrice!) * 100 : 0;

  ProductModel copyWith({bool? isFavorite}) => ProductModel(
    categoryId: categoryId,
    id: id,
    name: name,
    imageUrl: imageUrl,
    price: price,
    oldPrice: oldPrice,
    description: description,
    rating: rating,
    colors: colors,
    sizes: sizes,
    specialty: specialty,
    location: location,
    nameStore: nameStore,
    isFavorite: isFavorite ?? this.isFavorite,
  );
}
