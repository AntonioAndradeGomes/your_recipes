import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? photoUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.photoUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}
