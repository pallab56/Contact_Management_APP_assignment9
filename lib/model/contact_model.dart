// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ContactModel {
  final int? id;
  final String name;
  final String email;
  final String number;
  final String address;
  final int isFavourite;
  ContactModel({
    this.id,
    required this.name,
    required this.email,
    required this.number,
    required this.address,
    this.isFavourite = 0,
  });

  ContactModel copyWith({
    int? id,
    String? name,
    String? email,
    String? number,
    String? address,
    int? isFavourite,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      number: number ?? this.number,
      address: address ?? this.address,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'number': number,
      'address': address,
      'isFavourite': isFavourite,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      email: map['email'] as String,
      number: map['number'] as String,
      address: map['address'] as String,
      isFavourite: map['isFavourite'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ContactModel(id: $id, name: $name, email: $email, number: $number, address: $address, isFavourite: $isFavourite)';
  }

  @override
  bool operator ==(covariant ContactModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.number == number &&
      other.address == address &&
      other.isFavourite == isFavourite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      number.hashCode ^
      address.hashCode ^
      isFavourite.hashCode;
  }
}
