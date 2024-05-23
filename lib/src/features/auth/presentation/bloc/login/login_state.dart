part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  final UserEntity? userEntity;
  final CustomException? customException;

  const LoginState({
    this.userEntity,
    this.customException,
  });

  @override
  List<Object?> get props => [
        userEntity,
        customException,
      ];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  const LoginSuccess(
    UserEntity userEntity,
  ) : super(
          userEntity: userEntity,
        );
}

class LoginError extends LoginState {
  const LoginError(
    CustomException exception,
  ) : super(
          customException: exception,
        );
}
