import 'package:equatable/equatable.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class AuthenticatedState extends LoginState {
  final String userId;

  const AuthenticatedState({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

class UnauthenticatedState extends LoginState {
  final String? code;
  final String message;

  const UnauthenticatedState({
    required this.code,
    required this.message,
  });

  @override
  List<Object> get props => [
        code!,
        message,
      ];
}
