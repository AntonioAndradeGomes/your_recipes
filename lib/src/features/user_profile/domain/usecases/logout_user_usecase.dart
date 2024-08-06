import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';
import 'package:your_recipes/src/common/usecases/usecase.dart';
import 'package:your_recipes/src/features/user_profile/domain/repository/profile_repository.dart';

class LogoutUserUseCase implements Usecase<NoParams, NoParams> {
  final ProfileRepository _repository;

  LogoutUserUseCase({
    required ProfileRepository repository,
  }) : _repository = repository;
  @override
  Future<Result<NoParams, CustomException>> call(NoParams input) {
    return _repository.logout();
  }
}
