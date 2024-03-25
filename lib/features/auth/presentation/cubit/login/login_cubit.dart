import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipes/features/auth/domain/usecases/login_with_google/login_with_google_usecase.dart';
import 'package:your_recipes/features/auth/presentation/cubit/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginWithGoogleUsecase loginWithGoogleUsecase;
  LoginCubit({
    required this.loginWithGoogleUsecase,
  }) : super(
          InitialLoginState(),
        );

  Future<void> singInWithGoogle() async {
    emit(LoadingLoginState());
    final result = await loginWithGoogleUsecase.call();
    result.fold(
      (success) {
        emit(
          AuthenticatedState(
            userId: success,
          ),
        );
      },
      (failure) {
        emit(
          UnauthenticatedState(
            code: failure.code,
            message: failure.customMessage ?? 'Erro desconhecido',
          ),
        );
      },
    );
  }
}
