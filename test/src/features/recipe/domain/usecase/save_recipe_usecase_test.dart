import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/common/entities/ingredient_entity.dart';
import 'package:your_recipes/src/common/entities/recipe_entity.dart';
import 'package:your_recipes/src/common/entities/step_recipe_entity.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';
import 'package:your_recipes/src/features/recipe/domain/repository/recipe_repository.dart';
import 'package:your_recipes/src/features/recipe/domain/usecase/save_recipe_usecase.dart';

class MockRecipeRepository extends Mock implements RecipeRepository {}

void main() {
  late RecipeRepository recipeRepository;
  late SaveRecipeUseCase useCase;

  setUp(() {
    recipeRepository = MockRecipeRepository();
    useCase = SaveRecipeUseCase(recipeRepository);
  });

  final recipeMedia = RecipeEntity(
    name: 'Bolo de morango',
    baseIngredients: [
      IngredientEntity(
        name: '2kg de Açucar',
      ),
    ],
    baseSteps: [
      StepRecipeEntity(
        description: 'Misture',
      ),
    ],
    description: 'Bolo gostoso',
    portions: '2 pessoas',
    imagens: const [],
    newImages: const [],
  );

  group(
    'SaveRecipeUseCase',
    () {
      test(
        'should save a sent recipe',
        () async {
          when(
            () => recipeRepository.saveRecipe(recipeMedia),
          ).thenAnswer(
            (_) async => Result.success(recipeMedia),
          );
          final result = await useCase.call(recipeMedia);

          expect(result.isSuccess(), true);
          expect(result.getOrNull(), recipeMedia);
          verify(() => recipeRepository.saveRecipe(recipeMedia)).called(1);
        },
      );

      test(
        'should return an error when saveRecipe fails',
        () async {
          const execption = CustomException(
            messageError: 'Failed to save recipe',
          );

          when(
            () => recipeRepository.saveRecipe(recipeMedia),
          ).thenAnswer(
            (_) async => const Result.failure(execption),
          );
          final result = await useCase.call(recipeMedia);
          expect(result.isSuccess(), false);
          expect(result.isError(), true);
          expect(result.exceptionOrNull(), execption);
          verify(() => recipeRepository.saveRecipe(recipeMedia)).called(1);
        },
      );
    },
  );
}
