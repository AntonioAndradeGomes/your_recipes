import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  //pode ser um File ou String ou null
  final dynamic photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String provide;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.provide,
  });

  UserEntity copyWith({
    String? id,
    String? email,
    String? name,
    dynamic photoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? provide,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      provide: provide ?? this.provide,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        photoUrl,
        createdAt,
        updatedAt,
        provide,
      ];
}
