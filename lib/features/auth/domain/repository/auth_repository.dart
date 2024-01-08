import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/common/error/custom_exception.dart';

abstract class AuthRepository {
  Future<Result<String, CustomException>> loginWithGoogle();
}
