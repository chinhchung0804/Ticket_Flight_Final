class Flight {
  final String fromCode;
  final String fromName;
  final String toCode;
  final String toName;
  final String flyingTime;
  final String departureTime;
  final double price;  // Thêm trường price

  Flight({
    required this.fromCode,
    required this.fromName,
    required this.toCode,
    required this.toName,
    required this.flyingTime,
    required this.departureTime,
    required this.price, // Khai báo price
  });

  // Phương thức fromMap (Cập nhật để xử lý `price`)
  factory Flight.fromMap(Map<String, dynamic> map) {
    return Flight(
      fromCode: map['from']['code'] ?? '',
      fromName: map['from']['name'] ?? '',
      toCode: map['to']['code'] ?? '',
      toName: map['to']['name'] ?? '',
      flyingTime: map['flying_time'] ?? '',
      departureTime: map['thoi_gian_khoi_hanh'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(), // Xử lý giá trị `price`
    );
  }

  // Phương thức toMap (Tùy chọn: dùng khi cần lưu dữ liệu)
  Map<String, dynamic> toMap() {
    return {
      'from': {
        'code': fromCode,
        'name': fromName,
      },
      'to': {
        'code': toCode,
        'name': toName,
      },
      'flying_time': flyingTime,
      'thoi_gian_khoi_hanh': departureTime,
      'price': price, // Đảm bảo lưu trường price vào Firestore
    };
  }
}
