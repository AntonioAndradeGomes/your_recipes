import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipes/features/auth/domain/usecases/auth_changes/auth_changes_usecase.dart';
import 'package:your_recipes/features/auth/presentation/cubit/auth_changes/auth_changes_state.dart';

class AuthChangesCubit extends Cubit<AuthChangesState> {
  final AuthChangesUsecase usecase;
  AuthChangesCubit({
    required this.usecase,
  }) : super(InitialAuthChangesState()) {
    usecase.call().listen((event) {
      if (event != null) {
        emit(AuthenticatedState(
          user: event,
        ));
      } else {
        emit(UnauthenticatedState());
      }
    });
  }
}
