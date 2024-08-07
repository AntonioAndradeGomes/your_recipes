import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';
import 'package:your_recipes/src/features/auth/domain/entities/user_entity.dart';

part 'user_update_event.dart';
part 'user_update_state.dart';

class UserUpdateBloc extends Bloc<UserUpdateEvent, UserUpdateState> {
  UserUpdateBloc()
      : super(
          UserUpdateState.initial(),
        ) {}
}
