import 'package:your_recipes/common/error/custom_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract class LoginWithGoogleUsecase {
  Future<Result<void, CustomException>> call();
}
