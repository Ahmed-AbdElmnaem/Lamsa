class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    this.description,
    this.rating,
    this.isFavorite = false,
  });

  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double?
  oldPrice; // السعر قبل الخصم – يعرض بخط مائل وتخطيط (strike‑through)
  final String? description;
  final double? rating; // 0–5
  final bool isFavorite;

  bool get hasDiscount => oldPrice != null && oldPrice! > price;
  double get discountPerc =>
      hasDiscount ? ((oldPrice! - price) / oldPrice!) * 100 : 0;
}
