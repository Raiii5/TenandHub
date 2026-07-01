class BookingModel {
  final String id;
  final String boothId;
  final String tenantId;
  final DateTime bookingDate;

  const BookingModel({
    required this.id,
    required this.boothId,
    required this.tenantId,
    required this.bookingDate,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null ||
        json['booth_id'] == null ||
        json['tenant_id'] == null ||
        json['booking_date'] == null) {
      throw const FormatException(
        'Missing required fields in BookingModel JSON',
      );
    }

    DateTime parsedBookingDate;
    try {
      parsedBookingDate = DateTime.parse(json['booking_date'].toString());
    } catch (_) {
      throw const FormatException(
        'Invalid booking_date format in BookingModel JSON',
      );
    }

    return BookingModel(
      id: json['id'] as String,
      boothId: json['booth_id'] as String,
      tenantId: json['tenant_id'] as String,
      bookingDate: parsedBookingDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'booth_id': boothId,
      'tenant_id': tenantId,
      'booking_date': bookingDate.toIso8601String(),
    };
  }
}
