import 'package:equatable/equatable.dart';
import 'package:your_recipes/src/common/entities/step_recipe_entity.dart';

class StepRecipeSectionEntity extends Equatable {
  final int pos;
  final String description;
  final List<StepRecipeEntity> steps;

  const StepRecipeSectionEntity({
    required this.pos,
    required this.description,
    required this.steps,
  });

  @override
  List<Object?> get props => [
        pos,
        description,
        steps,
      ];
}
