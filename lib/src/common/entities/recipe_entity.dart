import 'package:equatable/equatable.dart';
import 'package:your_recipes/src/common/entities/ingredient_entity.dart';
import 'package:your_recipes/src/common/entities/step_recipe_entity.dart';

// ignore: must_be_immutable
class RecipeEntity extends Equatable {
  String? id;
  String? userId;
  String? name;
  String? description;
  List<String>? images;
  List<dynamic>? newImages;
  List<dynamic>? baseIngredients;
  List<StepRecipeEntity>? baseSteps;
  String? portions;
  String? preparationTime;

  RecipeEntity({
    this.id,
    this.userId,
    this.name,
    this.description,
    this.images,
    this.newImages,
    this.baseIngredients,
    this.baseSteps,
    this.portions,
    this.preparationTime,
  });

  RecipeEntity.empty()
      : id = null,
        userId = null,
        name = null,
        description = null,
        images = [],
        baseIngredients = [
          IngredientEntity(),
          IngredientEntity(),
        ],
        baseSteps = [
          StepRecipeEntity(),
          StepRecipeEntity(),
        ],
        portions = null,
        newImages = [],
        preparationTime = null;

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        description,
        images,
        newImages,
        baseIngredients,
        baseSteps,
        portions,
        preparationTime,
      ];
}
