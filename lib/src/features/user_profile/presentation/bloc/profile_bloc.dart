import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipes/src/common/usecases/usecase.dart';
import 'package:your_recipes/src/features/auth/domain/entities/user_entity.dart';
import 'package:your_recipes/src/features/user_profile/domain/usecases/get_user_usecase.dart';
import 'package:your_recipes/src/features/user_profile/domain/usecases/logout_user_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserUsecase _getUserUsecase;
  final LogoutUserUseCase _logoutUserUseCase;
  ProfileBloc({
    required GetUserUsecase getUserUseCase,
    required LogoutUserUseCase logoutUserUseCase,
  })  : _getUserUsecase = getUserUseCase,
        _logoutUserUseCase = logoutUserUseCase,
        super(ProfileLoadingState()) {
    on<GetUserEvent>(_onLoadUser);
    on<LogoutUserEvent>(_onLogoutUser);
    add(GetUserEvent());
  }

  Future<void> _onLoadUser(
    GetUserEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadingState());
    final userStream = _getUserUsecase.call();
    await emit.forEach<UserEntity?>(userStream, onData: (user) {
      if (user != null) {
        return ProfileSuccessState(user);
      }
      return ProfileLoadingState();
    }, onError: (err, st) {
      log(
        'error: $err',
        error: err,
        stackTrace: st,
        time: DateTime.now(),
      );
      return ProfileErrorState(
        err.toString(),
      );
    });
  }

  Future<void> _onLogoutUser(
    LogoutUserEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadingState());
    final result = await _logoutUserUseCase.call(NoParams());
    result.fold(
      (_) {
        add(GetUserEvent());
      },
      (err) {
        return ProfileErrorState(
          err.customMessage!,
        );
      },
    );
  }
}
