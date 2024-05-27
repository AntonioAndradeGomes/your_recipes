import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';
import 'package:your_recipes/src/common/error/firebase_errors/login_with_google_failure.dart';
import 'package:your_recipes/src/features/auth/data/datasource/auth_datasource.dart';
import 'package:your_recipes/src/features/auth/domain/entities/user_entity.dart';
import 'package:your_recipes/src/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource _authDatasource;

  AuthRepositoryImpl(
    this._authDatasource,
  );

  @override
  Future<Result<UserEntity, CustomException>> loginWithGoogle() async {
    try {
      final result = await _authDatasource.signInWithGoogle();
      return Success(result);
    } catch (e, s) {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        time: DateTime.now(),
      );
      if (e is FirebaseAuthException) {
        //final error = handleAuthError(e);
        return Failure(
          LogInWithGoogleFailure.fromFirebaseException(
            e,
          ),
        );
      }
      if (e is PlatformException) {
        log('PlatformException ${e.code}');
        return Failure(
          LogInWithGoogleFailure.abortLogin(
            e.code,
          ),
        );
      }
      if (e.runtimeType == String && e.toString() == 'popup_closed') {
        return Failure(
          LogInWithGoogleFailure.abortLogin(
            'popup_closed',
          ),
        );
      }
      return const Failure(
        LogInWithGoogleFailure(),
      );
    }
  }

  @override
  Stream<UserEntity?> authStateChanges() {
    return _authDatasource.authStateChanges();
  }
}
