part of 'user_update_bloc.dart';

class UserUpdateState extends Equatable {
  final UserEntity? previousUser;
  final UserEntity? updatedUser;
  final bool isLoading;
  final CustomException? exception;
  final bool isSuccess;

  const UserUpdateState({
    this.previousUser,
    this.updatedUser,
    this.isLoading = false,
    this.exception,
    this.isSuccess = false,
  });

  UserUpdateState copyWith({
    UserEntity? previousUser,
    UserEntity? updatedUser,
    bool? isLoading,
    CustomException? exception,
    bool? isSuccess,
  }) {
    return UserUpdateState(
      previousUser: previousUser ?? this.previousUser,
      updatedUser: updatedUser ?? this.updatedUser,
      isLoading: isLoading ?? this.isLoading,
      exception: exception ?? this.exception,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  factory UserUpdateState.initial() {
    return const UserUpdateState(
      previousUser: null,
      updatedUser: null,
      isLoading: false,
      exception: null,
      isSuccess: false,
    );
  }

  bool get isModified => previousUser != updatedUser;

  bool get hasError => exception != null;

  bool get hasSucceeded => isSuccess && !isLoading;

  bool get isInitial => this == UserUpdateState.initial();

  @override
  List<Object?> get props => [
        previousUser,
        updatedUser,
        isLoading,
        isSuccess,
        exception,
      ];
}
