import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipes/features/auth/presentation/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit()
      : super(
          InitialLoginState(),
        );

  Future<void> singInWithGoogle() async {
    emit(LoadingLoginState());
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    emit(AuthenticatedState());
  }
}
