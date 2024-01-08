import 'package:equatable/equatable.dart';

class CustomException extends Equatable implements Exception {
  final String? code;
  final String? messageFirebase;
  final String? message;

  const CustomException({
    this.code,
    this.messageFirebase,
    this.message,
  });

  @override
  List<Object?> get props => [code, message, messageFirebase];
}
