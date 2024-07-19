import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';
import 'package:your_recipes/src/common/usecases/usecase.dart';
import 'package:your_recipes/src/features/auth/domain/entities/user_entity.dart';
import 'package:your_recipes/src/features/auth/domain/repository/auth_repository.dart';

class LoginWithGoogle implements Usecase<UserEntity, NoParams> {
  final AuthRepository _authRepository;

  LoginWithGoogle({required AuthRepository repository})
      : _authRepository = repository;

  @override
  Future<Result<UserEntity, CustomException>> call(NoParams noParams) {
    return _authRepository.loginWithGoogle();
  }
}
