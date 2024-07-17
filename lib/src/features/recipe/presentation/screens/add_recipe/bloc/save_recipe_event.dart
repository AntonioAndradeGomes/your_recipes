import 'package:your_recipes/src/features/recipe/domain/entities/recipe_entity.dart';

sealed class SaveRecipeEvent {}

class SubmitSaveRecipeEvent extends SaveRecipeEvent {
  final RecipeEntity recipeEntity;

  SubmitSaveRecipeEvent({
    required this.recipeEntity,
  });
}
