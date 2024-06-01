import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';
import 'package:your_recipes/src/features/auth/domain/entities/user_entity.dart';
import 'package:your_recipes/src/features/auth/domain/usecases/login_with_google.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginWithGoogle _loginWithGoogleUseCase;
  LoginBloc({required LoginWithGoogle loginWithGoogleUseCase})
      : _loginWithGoogleUseCase = loginWithGoogleUseCase,
        super(
          LoginInitial(),
        ) {
    on<LoginGoogleSignUp>(
      _onLoginGoogle,
    );
  }

  Future<void> _onLoginGoogle(
    LoginGoogleSignUp event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final res = await _loginWithGoogleUseCase.call();
    res.fold(
      (success) => emit(LoginSuccess(success)),
      (error) => emit(LoginError(error)),
    );
  }
}
