import 'package:equatable/equatable.dart';
import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';

abstract class Usecase<Output extends Object, Input> {
  Future<Result<Output, CustomException>> call(Input input);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
