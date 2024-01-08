import 'package:your_recipes/common/error/custom_exception.dart';
import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/features/auth/domain/repository/auth_repository.dart';

abstract class LoginWithGoogleUsecase {
  Future<Result<String, CustomException>> call();
}

class LoginWithGoogleUsecaseImp extends LoginWithGoogleUsecase {
  final AuthRepository repository;

  LoginWithGoogleUsecaseImp({
    required this.repository,
  });

  @override
  Future<Result<String, CustomException>> call() async {
    return await repository.loginWithGoogle();
  }
}
