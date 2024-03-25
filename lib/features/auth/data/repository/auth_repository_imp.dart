import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/common/error/firebase_errors/login_with_google_failure.dart';
import 'package:your_recipes/features/auth/data/datasources/auth_datasource.dart';
import 'package:your_recipes/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImp({
    required this.datasource,
  });

  @override
  Future<Result<String, LogInWithGoogleFailure>> loginWithGoogle() async {
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
        //final error = handleAuthError(e);
        return Failure(
          LogInWithGoogleFailure.fromFirebaseException(
            e,
          ),
        );
      }
      if (e is PlatformException) {
        print('PlatformException ${e.code}');
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
        // code: 'unknown_error',
        // message: 'Um erro desconhecido aconteceu. Tente novamente mais tarde',
      );
    }
  }

  @override
  Stream<User?> getUserChanges() {
    return datasource.getUserChanges();
  }
}
