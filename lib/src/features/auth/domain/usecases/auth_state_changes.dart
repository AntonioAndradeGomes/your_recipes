import 'package:your_recipes/src/features/auth/domain/repository/auth_repository.dart';

class AuthStateChanges {
  final AuthRepository _authRepository;
  AuthStateChanges({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  Stream<bool> call() {
    return _authRepository.authStateChanges();
  }
}
