import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';
import 'package:your_recipes/src/features/auth/domain/entities/user_entity.dart';
import 'package:your_recipes/src/features/auth/domain/repository/auth_repository.dart';

class LoginWithGoogle {
  final AuthRepository _authRepository;

  const LoginWithGoogle(this._authRepository);

  Future<Result<UserEntity, CustomException>> call() {
    return _authRepository.loginWithGoogle();
  }
}
