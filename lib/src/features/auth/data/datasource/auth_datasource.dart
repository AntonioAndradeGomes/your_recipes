import 'package:your_recipes/src/features/auth/data/models/user_model.dart';

abstract class AuthDatasource {
  Future<UserModel> signInWithGoogle();
  Stream<UserModel?> authStateChanges();
}
