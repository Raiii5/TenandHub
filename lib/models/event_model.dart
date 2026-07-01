class EventModel {
  final String id;
  final String eoId;
  final String title;
  final DateTime date;
  final String location;

  const EventModel({
    required this.id,
    required this.eoId,
    required this.title,
    required this.date,
    required this.location,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null ||
        json['eo_id'] == null ||
        json['title'] == null ||
        json['date'] == null ||
        json['location'] == null) {
      throw const FormatException('Missing required fields in EventModel JSON');
    }

    DateTime parsedDate;
    try {
      final dateRaw = json['date'].toString();
      if (dateRaw.contains('T') || dateRaw.contains('-')) {
        parsedDate = DateTime.parse(dateRaw);
      } else {
        parsedDate = DateTime.now();
      }
    } catch (_) {
      parsedDate = DateTime.now();
    }

    return EventModel(
      id: json['id'] as String,
      eoId: json['eo_id'] as String,
      title: json['title'] as String,
      date: parsedDate,
      location: json['location'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eo_id': eoId,
      'title': title,
      'date': date.toIso8601String().split('T')[0],
    };
  }
}
