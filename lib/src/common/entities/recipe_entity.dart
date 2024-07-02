import 'package:equatable/equatable.dart';
import 'package:your_recipes/src/common/entities/ingredient_entity.dart';
import 'package:your_recipes/src/common/entities/step_recipe_entity.dart';

class RecipeEntity extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final List<dynamic>? imagens;
  final List<IngredientEntity>? baseIngredients;
  final List<StepRecipeEntity>? baseSteps;

  const RecipeEntity({
    this.baseSteps,
    this.id,
    this.name,
    this.description,
    this.baseIngredients,
    this.imagens,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        baseIngredients,
        imagens,
        baseSteps,
      ];
}
