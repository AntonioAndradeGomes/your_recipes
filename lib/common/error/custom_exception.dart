import 'package:equatable/equatable.dart';

class CustomException extends Equatable implements Exception {
  final String? code;

  final String? message;

  const CustomException({
    this.code,
    this.message,
  });

  @override
  List<Object?> get props => [code, message];
}
