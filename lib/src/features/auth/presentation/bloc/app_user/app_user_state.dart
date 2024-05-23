part of 'app_user_cubit.dart';

sealed class AppUserState extends Equatable {
  final UserEntity? userEntity;

  const AppUserState({
    this.userEntity,
  });

  @override
  List<Object?> get props => [userEntity];
}

class AppUserLoading extends AppUserState {}

class AppUserAuthenticated extends AppUserState {
  const AppUserAuthenticated(UserEntity userEntity)
      : super(
          userEntity: userEntity,
        );
}

class AppUserUnauthenticated extends AppUserState {}
