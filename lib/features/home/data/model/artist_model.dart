class ArtistModel {
  const ArtistModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    this.rating,
  });

  final String id;
  final String name;
  final String specialty;
  final String imageUrl;
  final double? rating;
}
