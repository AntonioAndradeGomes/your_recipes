import 'package:firebase_auth/firebase_auth.dart';
import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/common/error/firebase_errors/login_with_google_failure.dart';

abstract class AuthRepository {
  Future<Result<String, LogInWithGoogleFailure>> loginWithGoogle();

  Stream<User?> getUserChanges();
}
