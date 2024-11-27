class Hotel {
  final String destination;
  final String detail;
  final String image; // Ảnh chính
  final List<String> images; // Ảnh phụ
  final String place;
  final double price;

  Hotel({
    required this.destination,
    required this.detail,
    required this.image,
    required this.images,
    required this.place,
    required this.price,
  });

  factory Hotel.fromMap(Map<String, dynamic> data) {
    return Hotel(
      destination: data['destination'] ?? '',
      detail: data['detail'] ?? '',
      image: data['image'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      place: data['place'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'destination': destination,
      'detail': detail,
      'image': image,
      'images': images,
      'place': place,
      'price': double.parse(price.toStringAsFixed(3)),
    };
  }
}
