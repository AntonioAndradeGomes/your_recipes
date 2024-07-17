import 'package:equatable/equatable.dart';
import 'package:your_recipes/src/features/recipe/domain/entities/recipe_entity.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';

sealed class SaveRecipeState extends Equatable {
  final RecipeEntity? recipeEntity;
  final CustomException? customException;

  const SaveRecipeState({
    this.customException,
    this.recipeEntity,
  });

  @override
  List<Object?> get props => [
        recipeEntity,
        customException,
      ];
}

class SaveRecipeInitial extends SaveRecipeState {}

class SaveRecipeLoading extends SaveRecipeState {}

class SaveRecipeSuccess extends SaveRecipeState {
  const SaveRecipeSuccess(
    RecipeEntity recipeEntity,
  ) : super(
          recipeEntity: recipeEntity,
        );
}

class SaveRecipeError extends SaveRecipeState {
  const SaveRecipeError(
    CustomException customException,
  ) : super(
          customException: customException,
        );
}
