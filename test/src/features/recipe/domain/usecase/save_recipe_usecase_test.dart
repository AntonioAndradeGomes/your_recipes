import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/features/recipe/domain/entities/ingredient_entity.dart';
import 'package:your_recipes/src/features/recipe/domain/entities/recipe_entity.dart';
import 'package:your_recipes/src/features/recipe/domain/entities/step_recipe_entity.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';
import 'package:your_recipes/src/features/recipe/domain/repository/recipe_repository.dart';
import 'package:your_recipes/src/features/recipe/domain/usecase/save_recipe_usecase.dart';

class MockRecipeRepository extends Mock implements RecipeRepository {}

void main() {
  late RecipeRepository recipeRepository;
  late SaveRecipeUseCase useCase;

  setUp(() {
    recipeRepository = MockRecipeRepository();
    useCase = SaveRecipeUseCase(repository: recipeRepository);
  });

  final saveRecipe = RecipeEntity(
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
    images: const [],
    newImages: const [],
  );

  const execption = CustomException(
    messageError: 'Failed to save recipe',
  );

  final updateRecipe = RecipeEntity(
    id: 'abahsvahvahvahva',
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
    images: const [],
    newImages: const [],
  );

  group(
    'SaveRecipeUseCase',
    () {
      test(
        'should create a sent recipe',
        () async {
          when(
            () => recipeRepository.createRecipe(saveRecipe),
          ).thenAnswer(
            (_) async => Result.success(saveRecipe),
          );
          final result = await useCase.call(saveRecipe);

          expect(result.isSuccess(), true);
          expect(result.getOrNull(), saveRecipe);
          verify(() => recipeRepository.createRecipe(saveRecipe)).called(1);
        },
      );

      test(
        'should return an error when createRecipe fails',
        () async {
          when(
            () => recipeRepository.createRecipe(saveRecipe),
          ).thenAnswer(
            (_) async => const Result.failure(execption),
          );
          final result = await useCase.call(saveRecipe);
          expect(result.isSuccess(), false);
          expect(result.isError(), true);
          expect(result.exceptionOrNull(), execption);
          verify(() => recipeRepository.createRecipe(saveRecipe)).called(1);
        },
      );

      test(
        'should update a sent recipe',
        () async {
          when(
            () => recipeRepository.updateRecipe(updateRecipe),
          ).thenAnswer(
            (_) async => Result.success(updateRecipe),
          );
          final result = await useCase.call(updateRecipe);

          expect(result.isSuccess(), true);
          expect(result.getOrNull(), updateRecipe);
          verify(() => recipeRepository.updateRecipe(updateRecipe)).called(1);
        },
      );

      test(
        'should return an error when updateRecipe fails',
        () async {
          when(
            () => recipeRepository.updateRecipe(updateRecipe),
          ).thenAnswer(
            (_) async => const Result.failure(execption),
          );
          final result = await useCase.call(updateRecipe);
          expect(result.isSuccess(), false);
          expect(result.isError(), true);
          expect(result.exceptionOrNull(), execption);
          verify(() => recipeRepository.updateRecipe(updateRecipe)).called(1);
        },
      );
    },
  );
}
