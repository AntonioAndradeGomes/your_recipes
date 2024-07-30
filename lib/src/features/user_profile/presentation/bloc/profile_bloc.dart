import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipes/src/features/auth/domain/entities/user_entity.dart';
import 'package:your_recipes/src/features/user_profile/domain/usecases/get_user_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserUsecase _getUserUsecase;
  ProfileBloc({
    required GetUserUsecase getUserUseCase,
  })  : _getUserUsecase = getUserUseCase,
        super(ProfileLoadingState()) {
    on<GetUserEvent>(_onLoadUser);
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
}
