class TicketModel {
  final String id;
  final String trxId;
  final String title;
  final String date;
  final String time;
  final String location;
  final String image;
  final String boothName;
  final String price;
  final String status;
  final String paymentMethod;

  TicketModel({
    required this.id,
    required this.trxId,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.image,
    required this.boothName,
    required this.price,
    required this.status,
    required this.paymentMethod,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'trxId': trxId,
      'title': title,
      'date': date,
      'time': time,
      'location': location,
      'image': image,
      'boothName': boothName,
      'price': price,
      'status': status,
      'paymentMethod': paymentMethod,
    };
  }

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      id: map['id'],
      trxId: map['trxId'],
      title: map['title'],
      date: map['date'],
      time: map['time'],
      location: map['location'],
      image: map['image'],
      boothName: map['boothName'],
      price: map['price'],
      status: map['status'],
      paymentMethod: map['paymentMethod'],
    );
  }
}
