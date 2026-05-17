import 'dart:convert';

class ContactModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String? avatar;
  final bool isFavorite;

  ContactModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.avatar,
    this.isFavorite = false,
  });

  ContactModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatar,
    bool? isFavorite,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar ?? '',
      'isFavorite': isFavorite,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id']?.toString(),
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      avatar: map['avatar'],
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContactModel(id: $id, name: $name, email: $email, phone: $phone, isFavorite: $isFavorite)';
  }
}