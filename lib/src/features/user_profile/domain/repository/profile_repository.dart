import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';
import 'package:your_recipes/src/common/usecases/usecase.dart';
import 'package:your_recipes/src/features/auth/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Stream<UserEntity?> authenticatedUserStream();
  Future<Result<NoParams, CustomException>> logout();
}
