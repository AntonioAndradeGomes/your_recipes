part of 'user_update_bloc.dart';

sealed class UserUpdateEvent extends Equatable {
  final String? name;
  final dynamic image;
  final UserEntity? user;
  final UserEntity? initUser;

  const UserUpdateEvent({
    this.name,
    this.image,
    this.user,
    this.initUser,
  });

  @override
  List<Object?> get props => [
        name,
        image,
        user,
        initUser,
      ];
}

class StartUser extends UserUpdateEvent {}

class UpdateUserName extends UserUpdateEvent {
  const UpdateUserName(String name)
      : super(
          name: name,
        );
}

class UpdateUserPhoto extends UserUpdateEvent {
  const UpdateUserPhoto(dynamic image)
      : super(
          image: image,
        );
}

class SubmitUserData extends UserUpdateEvent {
  const SubmitUserData(UserEntity user)
      : super(
          user: user,
        );
}
