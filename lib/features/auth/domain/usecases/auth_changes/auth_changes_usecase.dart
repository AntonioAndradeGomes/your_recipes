import 'package:firebase_auth/firebase_auth.dart';
import 'package:your_recipes/features/auth/domain/repository/auth_repository.dart';

abstract class AuthChangesUsecase {
  Stream<User?> call();
}

class AuthChangesUsecaseImp extends AuthChangesUsecase {
  final AuthRepository repository;

  AuthChangesUsecaseImp({
    required this.repository,
  });

  @override
  Stream<User?> call() {
    return repository.getUserChanges();
  }
}
