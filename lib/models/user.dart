import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final DateTime createdAt; // Thêm thời gian tạo tài khoản
  final List<String> orderIds; // Danh sách các orderId
  final List<String> bookedHotelIds; // Danh sách các bookedHotelIds

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.createdAt,
    required this.orderIds,
    required this.bookedHotelIds,
  });

  // Tạo đối tượng User từ Map (dữ liệu từ Firestore)
  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      id: documentId,
      name: map['name'] ?? 'Guest',
      email: map['email'] ?? '',
      avatarUrl: map['avatarUrl'] ?? 'assets/images/user_avatar.jpg',
      createdAt: (map['createdAt'] as Timestamp).toDate(), // Chuyển Timestamp thành DateTime
      orderIds: List<String>.from(map['orderIds'] ?? []),
      bookedHotelIds: List<String>.from(map['bookedHotelIds'] ?? []),
    );
  }

  // Chuyển đối tượng User thành Map (để lưu vào Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'createdAt': createdAt,
      'orderIds': orderIds,
      'bookedHotelIds': bookedHotelIds,
    };
  }
}
