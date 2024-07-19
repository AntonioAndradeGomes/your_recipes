import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:your_recipes/src/features/auth/domain/usecases/auth_state_changes.dart';
part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final AuthStateChanges _authStateChanges;
  late final StreamSubscription _authSubscription;

  AppUserCubit({
    required AuthStateChanges authStateChangesUseCase,
  })  : _authStateChanges = authStateChangesUseCase,
        super(
          AppUserLoading(),
        ) {
    _init();
  }

  void _init() {
    emit(AppUserLoading());
    _authSubscription = _authStateChanges.call().listen(
      (auth) {
        if (!auth) {
          emit(AppUserUnauthenticated());
        } else {
          emit(AppUserAuthenticated());
        }
      },
    );
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
