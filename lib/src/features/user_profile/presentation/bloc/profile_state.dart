part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  final UserEntity? userEntity;
  const ProfileState({
    this.userEntity,
  });

  @override
  List<Object?> get props => [userEntity];
}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  const ProfileSuccessState(
    UserEntity userEntity,
  ) : super(
          userEntity: userEntity,
        );
}
