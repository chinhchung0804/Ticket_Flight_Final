import 'package:cloud_firestore/cloud_firestore.dart';

class BookHotel {
  final String id; // ID của tài liệu trong Firestore
  final String userId; // ID của người dùng đặt phòng
  final String destination;
  final String detail;
  final String image;
  final List<String> images;
  final String place;
  final double price;
  final double adults;
  final double beds;
  final double children;
  final Timestamp bookedAt;

  BookHotel({
    required this.id,
    required this.userId,
    required this.destination,
    required this.detail,
    required this.image,
    required this.images,
    required this.place,
    required this.adults,
    required this.beds,
    required this.children,
    required this.price,
    required this.bookedAt,
  });

  // Tạo phương thức factory để khởi tạo đối tượng BookHotel từ Firestore DocumentSnapshot
  factory BookHotel.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return BookHotel(
      id: snapshot.id, // Lấy ID từ Firestore
      userId: data['userId'] ?? '', // ID của người dùng
      images: List<String>.from(data['images'] ?? []),
      destination: data['destination'] is String ? data['destination'] : '',
    place: data['place'] is String ? data['place'] : '',
    detail: data['detail'] is String ? data['detail'] : '',
    image: data['image'] is String ? data['image'] : 'default_image.png',
    price: (data['price'] ?? 0).toDouble(),
     adults: (data['adults'] ?? 0).toDouble(),
      beds: (data['beds'] ?? 0).toDouble(),
       children: (data['children'] ?? 0).toDouble(),
    bookedAt: data['bookedAt'] is Timestamp
        ? data['bookedAt']
        : Timestamp.now(),
    );
  }

  // Phương thức chuyển đối tượng BookHotel thành Map (để lưu vào Firestore)
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'destination': destination,
      'detail': detail,
      'image': image,
      'images': images,
      'place': place,
      'price': price,
      'adults': adults,
      'beds': beds,
      'children': children,
      'bookedAt': bookedAt,
    };
  }
}
