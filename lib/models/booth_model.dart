class BoothModel {
  final String id;
  final String eventId;
  final String boothNumber;
  final String description;

  BoothModel({
    required this.id,
    required this.eventId,
    required this.boothNumber,
    required this.description,
  });

  factory BoothModel.fromJson(Map<String, dynamic> json) {
    return BoothModel(
      // Tanda ?? '' artinya: Kalau datanya null dari Supabase, isi dengan teks default agar tidak error
      id: json['id']?.toString() ?? '',
      eventId: json['event_id']?.toString() ?? '',
      boothNumber:
          json['booth_number']?.toString() ??
          json['name']?.toString() ??
          'Booth VIP',
      description: json['description']?.toString() ?? 'Tidak ada deskripsi',
    );
  }
}
