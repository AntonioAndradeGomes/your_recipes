import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:your_recipes/src/features/recipe/data/datasources/recipe_remote_datasource.dart';
import 'package:your_recipes/src/features/recipe/data/repository/recipe_repository_impl.dart';

class MockRecipeRemoteDatasource extends Mock
    implements RecipeRemoteDatasource {}

void main() {
  late RecipeRepositoryImpl recipeRepositoryImpl;
  late RecipeRemoteDatasource recipeRemoteDatasource;

  setUp(() {
    recipeRemoteDatasource = MockRecipeRemoteDatasource();
    recipeRepositoryImpl = RecipeRepositoryImpl(
      datasource: recipeRemoteDatasource,
    );
  });
}
