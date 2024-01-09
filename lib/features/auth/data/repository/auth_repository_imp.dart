import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/common/error/custom_exception.dart';
import 'package:your_recipes/common/helpers/handle_firebase_auth_errors.dart';
import 'package:your_recipes/features/auth/data/datasources/auth_datasource.dart';
import 'package:your_recipes/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImp({
    required this.datasource,
  });

  @override
  Future<Result<String, CustomException>> loginWithGoogle() async {
    try {
      final result = await datasource.signInGoogle();
      return Success(result);
    } catch (e, s) {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        time: DateTime.now(),
      );
      if (e is FirebaseAuthException) {
        final error = handleAuthError(e);
        return Failure(error);
      }
      if (e is PlatformException) {
        return Failure(
          CustomException(
            code: e.code,
            message: e.message,
          ),
        );
      }
      if (e.runtimeType == String && e.toString() == 'popup_closed') {
        return const Failure(
          CustomException(
            code: 'popup_closed',
            message: 'Processo de login abortado',
          ),
        );
      }
      return const Failure(
        CustomException(
          code: 'unknown_error',
          message: 'Um erro desconhecido aconteceu. Tente novamente mais tarde',
        ),
      );
    }
  }

  @override
  Stream<User?> getUserChanges() {
    return datasource.getUserChanges();
  }
}
