part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserEvent extends ProfileEvent {}

class LogoutUserEvent extends ProfileEvent {}
