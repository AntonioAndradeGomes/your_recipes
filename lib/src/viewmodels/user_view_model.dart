import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/error/custom_exception.dart';

import 'package:your_recipes/src/models/user_model.dart';
import 'package:your_recipes/src/repositories/i_user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final IUserRepository _repository;
  UserViewModel(
    this._repository,
  );
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<Result<UserModel, CustomException>> signInWithGoogle() async {
    loading = true;
    final user = await _repository.signInWithGoogle();
    loading = false;
    return user;
  }
}
