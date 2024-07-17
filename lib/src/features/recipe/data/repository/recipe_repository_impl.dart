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
  Future<Result<RecipeEntity, CustomException>> createRecipe(
    RecipeEntity entity,
  ) {
    //1 - chamar o datasource para criar a receita
    //2 - chamar o datasource para adicionar as imagens na receita
    throw UnimplementedError();
  }

  @override
  Future<Result<RecipeEntity, CustomException>> updateRecipe(
      RecipeEntity recipeEntity) {
    // TODO: implement updateRecipe
    throw UnimplementedError();
  }
}
