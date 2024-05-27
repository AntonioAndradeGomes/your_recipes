import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:your_recipes/src/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String email,
    required String name,
    String? photoUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String provide,
  }) : super(
          id: id,
          email: email,
          name: name,
          photoUrl: photoUrl,
          createdAt: createdAt,
          updatedAt: updatedAt,
          provide: provide,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String?,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
      provide: json['provide'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'provide': provide,
    };
  }
}
