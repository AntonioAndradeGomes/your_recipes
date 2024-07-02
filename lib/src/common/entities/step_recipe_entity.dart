import 'package:equatable/equatable.dart';

class StepRecipeEntity extends Equatable {
  final String description;
  final int pos;

  const StepRecipeEntity({
    required this.description,
    required this.pos,
  });

  @override
  List<Object?> get props => [description, pos];
}
