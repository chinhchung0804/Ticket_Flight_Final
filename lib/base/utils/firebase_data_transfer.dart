import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_app_final/base/utils/all_json.dart';

// Hàm để thêm vé máy bay vào Firestore
Future<void> addTicketData() async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Kiểm tra danh sách không rỗng trước khi thêm
  if (ticketList.isNotEmpty) {
    for (var ticket in ticketList) {
      try {
        await _firestore.collection('Flights').add({
          'from': ticket['from'],
          'to': ticket['to'],
          'price': ticket['price'],
          'flying_time': ticket['flying_time'],
          'thoi_gian_khoi_hanh': ticket['thoi_gian_khoi_hanh'],
        });
      } catch (e) {
        print('Error adding ticket: $e');
      }
    }
    print("Ticket data added successfully!");
  } else {
    print("No ticket data found to add!");
  }
}

// Hàm để thêm khách sạn vào Firestore
Future<void> addHotelData() async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  if (hotelList.isNotEmpty) {
    for (var hotel in hotelList) {
      try {
        await _firestore.collection('Hotels').add({
          'image': hotel['image'],
          'place': hotel['place'],
          'destination': hotel['destination'],
          'price': hotel['price'],
          'detail': hotel['detail'],
          'images': hotel['images'],
        });
      } catch (e) {
        print('Error adding hotel: $e');
      }
    }
    print("Hotel data added successfully!");
  } else {
    print("No hotel data found to add!");
  }
}

// Hàm để thêm các địa điểm nổi tiếng vào Firestore
Future<void> addPopularLocations() async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  if (locations.isNotEmpty) {
    for (var location in locations) {
      try {
        await _firestore.collection('PopularLocations').add({
          'name': location['name'],
          'description': location['description'],
          'image': location['image'],
          'airport': location['airport'],
          'images': location['images'],
        });
      } catch (e) {
        print('Error adding location: $e');
      }
    }
    print("Popular Location data added successfully!");
  } else {
    print("No location data found to add!");
  }
}

Future<void> deleteAllTickets() async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    // Lấy tất cả các tài liệu trong collection 'Flights'
    QuerySnapshot snapshot = await _firestore.collection('Flights').get();

    // Duyệt qua các tài liệu và xóa từng tài liệu
    for (var doc in snapshot.docs) {
      await doc.reference.delete();  // Xóa tài liệu theo reference
    }

    print("All tickets deleted successfully!");
  } catch (e) {
    print('Error deleting tickets: $e');
  }
}