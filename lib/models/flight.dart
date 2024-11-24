class Flight {
  final String number;
  final String date;
  final String flightTime;
  final String fromCode;
  final String fromName;
  final String toCode;
  final String toName;
  final String departureTime;

  Flight({
    required this.number,
    required this.date,
    required this.flightTime,
    required this.fromCode,
    required this.fromName,
    required this.toCode,
    required this.toName,
    required this.departureTime,
  });

  factory Flight.fromFirestore(Map<String, dynamic> data) {
    return Flight(
      number: data['number'],
      date: data['date'],
      flightTime: data['flight_time'],
      fromCode: data['from']['code'],
      fromName: data['from']['name'],
      toCode: data['to']['code'],
      toName: data['to']['name'],
      departureTime: data['thoi_gian_khoi_hanh'],
    );
  }
}
