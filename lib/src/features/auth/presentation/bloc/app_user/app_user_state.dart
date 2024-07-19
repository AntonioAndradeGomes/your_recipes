part of 'app_user_cubit.dart';

sealed class AppUserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppUserLoading extends AppUserState {}

class AppUserAuthenticated extends AppUserState {}

class AppUserUnauthenticated extends AppUserState {}
