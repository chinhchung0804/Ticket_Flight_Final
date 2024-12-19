import 'package:cloud_firestore/cloud_firestore.dart';

// Model cho đơn đặt vé
class orders {
  final String id; // ID của đơn đặt vé (Firestore Document ID)
  final String userId; // ID người dùng đặt vé
  final String from; // Điểm đi
  final String to; // Điểm đến
  final String flightNumber; // Số hiệu chuyến bay
  final String date; // Ngày bay
  final String departureTime; // Giờ khởi hành
  final String flyingTime; // Tổng thời gian bay
  final double price; // Giá vé
  final Timestamp bookingTime; // Thời gian đặt vé

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

  // Phương thức factory để khởi tạo đối tượng orders từ Firestore DocumentSnapshot
  factory orders.fromFirestore(DocumentSnapshot snapshot) {
  final data = snapshot.data() as Map<String, dynamic>;

  return orders(
    id: snapshot.id,
    userId: data['userId'] ?? '', // Default to empty string if null
    from: data['from'] is String ? data['from'] : '',
    to: data['to'] is String ? data['to'] : '',
    flightNumber: data['flightNumber'] is String ? data['flightNumber'] : '',
    date: data['date'] is String ? data['date'] : '',
    departureTime: data['departureTime'] is String ? data['departureTime'] : '',
    flyingTime: data['flyingTime'] is String ? data['flyingTime'] : '',
    price: (data['price'] ?? 0).toDouble(),
    bookingTime: data['bookingTime'] is Timestamp
        ? data['bookingTime']
        : Timestamp.now(),
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