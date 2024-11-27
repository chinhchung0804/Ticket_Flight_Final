import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class orders {
  final String id; // ID của đơn đặt vé (Firestore Document ID)
  final String userId; // ID người dùng đặt vé
  final String from;
  final String to;
  final String flightNumber;
  final String date;
  final String departureTime;
  final String flyingTime;
  final double price;
  final Timestamp bookingTime;

  orders({
    required this.id,
    required this.userId,
    required this.from,
    required this.to,
    required this.flightNumber,
    required this.date,
    required this.departureTime,
    required this.flyingTime,
    required this.price,
    required this.bookingTime,
  });

  // Tạo phương thức factory để khởi tạo đối tượng orders từ Firestore DocumentSnapshot
  factory orders.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return orders(
      id: snapshot.id,
      userId: data['userId'] ?? '', // ID của người dùng đặt vé
      from: data['from'] ?? '',
      to: data['to'] ?? '',
      flightNumber: data['flightNumber'] ?? '',
      date: data['date'] ?? '',
      departureTime: data['departureTime'] ?? '',
      flyingTime: data['flyingTime'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      bookingTime: data['bookingTime'] ?? Timestamp.now(),
    );
  }

  // Phương thức chuyển đối tượng orders thành Map (để lưu vào Firestore)
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'from': from,
      'to': to,
      'flightNumber': flightNumber,
      'date': date,
      'departureTime': departureTime,
      'flyingTime': flyingTime,
      'price': price,
      'bookingTime': bookingTime,
    };
  }
}
