class PopularLocations {
  final String name;
  final String description;
  final String image;
  final String airport;
  final List<String> images;

  PopularLocations({
    required this.name,
    required this.description,
    required this.image,
    required this.airport,
    required this.images,
  });

  // Factory method to convert Firestore document into PopularLocations object
  factory PopularLocations.fromMap(Map<String, dynamic> data) {
    return PopularLocations(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
      airport: data['airport'] ?? '',
      images: List<String>.from(data['images'] ?? []),
    );
  }

  // Convert PopularLocations object to a Map for saving to Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'airport': airport,
      'images': images,
    };
  }
}