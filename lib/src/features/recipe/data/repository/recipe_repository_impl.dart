import 'package:result_dart/src/result.dart';
import 'package:your_recipes/src/common/entities/recipe_entity.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';
import 'package:your_recipes/src/features/recipe/data/datasources/recipe_remote_datasource.dart';
import 'package:your_recipes/src/features/recipe/domain/repository/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDatasource _recipeRemoteDatasource;

  RecipeRepositoryImpl(
    this._recipeRemoteDatasource,
  );
  @override
  Future<Result<RecipeEntity, CustomException>> saveRecipe(
    RecipeEntity entity,
  ) {
    // TODO: implement saveRecipe
    throw UnimplementedError();
  }
}
