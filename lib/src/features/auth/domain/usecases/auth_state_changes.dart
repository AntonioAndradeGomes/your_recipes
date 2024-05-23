import 'package:your_recipes/src/features/auth/domain/entities/user_entity.dart';
import 'package:your_recipes/src/features/auth/domain/repository/auth_repository.dart';

class AuthStateChanges {
  final AuthRepository _authRepository;
  AuthStateChanges(this._authRepository);

  Stream<UserEntity?> call() {
    return _authRepository.authStateChanges();
  }
}
