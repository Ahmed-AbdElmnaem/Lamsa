class CategoryModel {
  final String id;
  final String iconPath;
  final String label;

  const CategoryModel({
    required this.id,
    required this.iconPath,
    required this.label,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'] as String,
    iconPath: json['icon'] as String,
    label: json['label'] as String,
  );

  Map<String, dynamic> toJson() => {'id': id, 'icon': iconPath, 'label': label};
}
