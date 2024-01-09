import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

sealed class AuthChangesState extends Equatable {
  const AuthChangesState();

  @override
  List<Object> get props => [];
}

class InitialAuthChangesState extends AuthChangesState {}

class AuthenticatedState extends AuthChangesState {
  final User user;

  const AuthenticatedState({
    required this.user,
  });

  @override
  List<Object> get props => [
        user,
      ];
}

class UnauthenticatedState extends AuthChangesState {}
