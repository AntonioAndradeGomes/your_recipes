import 'package:equatable/equatable.dart';

class CustomException extends Equatable implements Exception {
  final String? code;
  //mensagem retornada do erro
  final String? messageError;
  //mensagem que eu quero mostar
  final String? customMessage;

  const CustomException({
    this.code,
    this.customMessage,
    this.messageError,
  });

  @override
  List<Object?> get props => [
        code,
        customMessage,
        messageError,
      ];
}
