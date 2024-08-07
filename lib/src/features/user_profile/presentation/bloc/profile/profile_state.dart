part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  final UserEntity? userEntity;
  final String? error;
  const ProfileState({
    this.userEntity,
    this.error,
  });

  @override
  List<Object?> get props => [
        userEntity,
        error,
      ];
}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  const ProfileSuccessState(
    UserEntity userEntity,
  ) : super(
          userEntity: userEntity,
        );
}

class ProfileErrorState extends ProfileState {
  const ProfileErrorState(
    String error,
  ) : super(
          error: error,
        );
}
