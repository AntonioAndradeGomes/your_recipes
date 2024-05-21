import 'dart:async';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/error/custom_exception.dart';
import 'package:your_recipes/src/models/user_model.dart';
import 'package:your_recipes/src/repositories/i_user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final IUserRepository _repository;
  late StreamSubscription<UserModel?> _userSubscription;
  UserViewModel(
    this._repository,
  ) {
    _userSubscription = _repository.getUserChanges().listen(
      (user) {
        _user = user;
        notifyListeners();
      },
    );
  }

  UserModel? _user;

  UserModel? get user => _user;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<Result<UserModel, CustomException>> signInWithGoogle() async {
    loading = true;
    final res = await _repository.signInWithGoogle();
    loading = false;
    return res;
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }
}
