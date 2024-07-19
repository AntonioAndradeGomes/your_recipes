import 'package:equatable/equatable.dart';
import 'package:your_recipes/src/features/recipe/domain/entities/ingredient_entity.dart';
import 'package:your_recipes/src/features/recipe/domain/entities/step_recipe_entity.dart';

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
  DateTime? createdAt;
  DateTime? updatedAt;

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
    this.createdAt,
    this.updatedAt,
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
        preparationTime = null,
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

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
        createdAt,
        updatedAt,
      ];
}
