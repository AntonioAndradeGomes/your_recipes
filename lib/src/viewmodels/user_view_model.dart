import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/error/custom_exception.dart';

import 'package:your_recipes/src/models/user_model.dart';

class UserViewModel extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<Result<UserModel, CustomException>> signInWithGoogle() async {
    loading = true;
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );
    loading = false;
    return Failure(
      CustomException(
        customMessage: 'Erro ao realizar login',
      ),
    );
    // return Success(UserModel());
  }
}
