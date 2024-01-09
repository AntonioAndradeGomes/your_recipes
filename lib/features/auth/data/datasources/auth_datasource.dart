import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDatasource {
  Future<String> signInGoogle();

  Stream<User?> getUserChanges();
}
