import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/error/custom_exception.dart';
import 'package:your_recipes/src/models/user_model.dart';

abstract class IUserRepository {
  Future<Result<String, CustomException>> signInWithGoogle();
}