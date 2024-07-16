import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/common/entities/recipe_entity.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';

abstract class RecipeRepository {
  Future<Result<RecipeEntity, CustomException>> saveRecipe(
    RecipeEntity entity,
  );
}
