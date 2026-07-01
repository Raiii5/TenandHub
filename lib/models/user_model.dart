class UserModel {
  final String id;
  final String name;
  final String role;

  const UserModel({required this.id, required this.name, required this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null || json['name'] == null || json['role'] == null) {
      throw const FormatException('Missing required fields in UserModel JSON');
    }

    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'role': role};
  }
}
