import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipes/features/auth/domain/usecases/auth_changes/auth_changes_usecase.dart';
import 'package:your_recipes/features/auth/presentation/cubit/auth_changes/auth_changes_state.dart';

class AuthChangesCubit extends Cubit<AuthChangesState> {
  final AuthChangesUsecase usecase;
  late StreamSubscription<User?> _subscription;
  AuthChangesCubit({
    required this.usecase,
  }) : super(InitialAuthChangesState()) {
    _subscription = usecase.call().listen((user) {
      if (user != null) {
        emit(AuthenticatedState(
          user: user,
        ));
      } else {
        emit(UnauthenticatedState());
      }
    });
  }

  @override
  Future<void> close() async {
    await super.close();
    return super.close();
  }
}
