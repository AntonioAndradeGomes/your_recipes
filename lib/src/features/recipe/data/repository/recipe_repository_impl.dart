import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/features/recipe/domain/entities/recipe_entity.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';
import 'package:your_recipes/src/features/recipe/data/datasources/recipe_remote_datasource.dart';
import 'package:your_recipes/src/features/recipe/data/models/recipe_model.dart';
import 'package:your_recipes/src/features/recipe/domain/repository/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDatasource _recipeRemoteDatasource;

  RecipeRepositoryImpl({
    required RecipeRemoteDatasource datasource,
  }) : _recipeRemoteDatasource = datasource;

  @override
  Future<Result<RecipeEntity, CustomException>> createRecipe(
    RecipeEntity entity,
  ) async {
    //1 - chamar o datasource para criar a receita
    final recipeResult = await _recipeRemoteDatasource.createRecipe(
      RecipeModel.fromEntity(entity),
    );
    return recipeResult.fold(
      (success) async {
        final recipe = success;
        //2 - chamar o datasource para adicionar as imagens na receita
        final images = await _recipeRemoteDatasource.uploadImages(
          recipe.newImages ?? [],
          recipe.images ?? [],
          recipe.id!,
        );
        recipe.images = images;
        recipe.newImages = [];
        return Result.success(recipe);
      },
      (failure) {
        return Result.failure(failure);
      },
    );
  }

  @override
  Future<Result<RecipeEntity, CustomException>> updateRecipe(
    RecipeEntity entity,
  ) async {
    // 1 chamar o datasource para atualizar a receita
    final recipeResult = await _recipeRemoteDatasource.updateRecipe(
      RecipeModel.fromEntity(entity),
    );
    return recipeResult.fold(
      (success) async {
        final recipe = success;
        //2 - chamar o datasource para adicionar as imagens na receita
        final images = await _recipeRemoteDatasource.uploadImages(
          recipe.newImages ?? [],
          recipe.images ?? [],
          recipe.id!,
        );
        recipe.images = images;
        recipe.newImages = [];
        return Result.success(recipe);
      },
      (failure) {
        return Result.failure(failure);
      },
    );
  }
}
