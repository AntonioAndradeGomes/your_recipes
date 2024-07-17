import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/features/recipe/domain/entities/recipe_entity.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';
import 'package:your_recipes/src/common/usecases/usecase.dart';
import 'package:your_recipes/src/features/recipe/domain/repository/recipe_repository.dart';

class SaveRecipeUseCase implements Usecase<RecipeEntity, RecipeEntity> {
  final RecipeRepository _repository;

  SaveRecipeUseCase({
    required RecipeRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<RecipeEntity, CustomException>> call(
    RecipeEntity input,
  ) {
    //fazer validações de null aqui e de formato da entidade -> regras de négocio.
    if (input.id == null) {
      return _repository.createRecipe(input);
    }
    return _repository.updateRecipe(input);
  }
}
