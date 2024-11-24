class Hotel {
  final String destination;
  final String detail;
  final String image;
  final List<String> images;
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

  factory Hotel.fromFirestore(Map<String, dynamic> data) {
    return Hotel(
      destination: data['destination'],
      detail: data['detail'],
      image: data['image'],
      images: List<String>.from(data['images']),
      place: data['place'],
      price: data['price'].toDouble(),
    );
  }
}
