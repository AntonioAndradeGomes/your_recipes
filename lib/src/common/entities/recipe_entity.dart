import 'package:equatable/equatable.dart';
import 'package:your_recipes/src/common/entities/ingredient_entity.dart';
import 'package:your_recipes/src/common/entities/step_recipe_entity.dart';

// ignore: must_be_immutable
class RecipeEntity extends Equatable {
  String? id;
  String? name;
  String? description;
  List<dynamic>? imagens;
  List<dynamic>? baseIngredients;
  List<StepRecipeEntity>? baseSteps;
  String? portions;
  String? preparationTime;

  RecipeEntity({
    this.baseSteps,
    this.id,
    this.name,
    this.description,
    this.baseIngredients,
    this.imagens,
    this.portions,
  });

  RecipeEntity.empty()
      : id = null,
        name = null,
        description = null,
        imagens = [],
        baseIngredients = [
          IngredientEntity(),
          IngredientEntity(),
        ],
        baseSteps = [
          StepRecipeEntity(),
          StepRecipeEntity(),
        ],
        portions = null,
        preparationTime = null;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        baseIngredients,
        imagens,
        baseSteps,
        portions,
        preparationTime,
      ];
}
