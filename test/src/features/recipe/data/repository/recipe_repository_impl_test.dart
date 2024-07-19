import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';
import 'package:your_recipes/src/features/recipe/data/datasources/recipe_remote_datasource.dart';
import 'package:your_recipes/src/features/recipe/data/models/recipe_model.dart';
import 'package:your_recipes/src/features/recipe/data/repository/recipe_repository_impl.dart';
import 'package:your_recipes/src/features/recipe/domain/entities/recipe_entity.dart';
import 'package:your_recipes/src/features/recipe/domain/repository/recipe_repository.dart';

class MockRecipeRemoteDatasource extends Mock
    implements RecipeRemoteDatasource {}

class FakeRecipeModel extends Fake implements RecipeModel {}

void main() {
  late RecipeRepository recipeRepositoryImpl;
  late RecipeRemoteDatasource recipeRemoteDatasource;

  setUpAll(() {
    registerFallbackValue(FakeRecipeModel());
  });

  setUp(() {
    recipeRemoteDatasource = MockRecipeRemoteDatasource();
    recipeRepositoryImpl = RecipeRepositoryImpl(
      datasource: recipeRemoteDatasource,
    );
  });

  group(
    'Create Recipe',
    () {
      final recipeEntity = RecipeEntity(
        id: '1',
        userId: 'user1',
        name: 'Recipe',
        description: 'A delicious recipe',
        images: const [],
        newImages: const [],
        baseIngredients: const [],
        baseSteps: const [],
        portions: '4',
        preparationTime: '00:30',
      );

      final recipeModel = RecipeModel.fromEntity(recipeEntity);

      test(
        'should return RecipeEntity when the recipe is created successfully',
        () async {
          when(
            () => recipeRemoteDatasource.createRecipe(any()),
          ).thenAnswer((_) async => Result.success(recipeModel));
          when(
            () => recipeRemoteDatasource.uploadImages(
              any(),
              any(),
              any(),
            ),
          ).thenAnswer(
            (_) async => ['image1.jpg'],
          );

          final result = await recipeRepositoryImpl.createRecipe(recipeEntity);

          expect(result.isSuccess(), true);
          expect(result.getOrNull(), isA<RecipeModel>());
          verify(() => recipeRemoteDatasource.createRecipe(any())).called(1);
          verify(
            () => recipeRemoteDatasource.uploadImages(
              any(),
              any(),
              any(),
            ),
          ).called(1);
        },
      );

      test(
        'should return CustomException when the recipe creation fails',
        () async {
          const exception = CustomException(
            messageError: 'Error creating recipe',
            customMessage: 'Erro ao criar receita',
          );
          when(
            () => recipeRemoteDatasource.createRecipe(any()),
          ).thenAnswer(
            (_) async => const Result.failure(exception),
          );

          final result = await recipeRepositoryImpl.createRecipe(recipeEntity);

          expect(result.isSuccess(), false);
          expect(result.getOrNull(), null);
          expect(result.isError(), true);
          expect(result.exceptionOrNull(), exception);
          verify(() => recipeRemoteDatasource.createRecipe(any())).called(1);
          verifyNever(
            () => recipeRemoteDatasource.uploadImages(
              any(),
              any(),
              any(),
            ),
          );
        },
      );
    },
  );

  group(
    'Update Recipe',
    () {
      final recipeEntity = RecipeEntity(
        id: '1',
        userId: 'user1',
        name: 'Updated Recipe',
        description: 'An updated delicious recipe',
        images: const [],
        newImages: const [],
        baseIngredients: const [],
        baseSteps: const [],
        portions: '4',
        preparationTime: '40 min',
      );

      final recipeModel = RecipeModel.fromEntity(recipeEntity);

      test(
        'should return RecipeEntity when the recipe is updated successfully',
        () async {
          when(
            () => recipeRemoteDatasource.updateRecipe(any()),
          ).thenAnswer((_) async => Result.success(recipeModel));
          when(
            () => recipeRemoteDatasource.uploadImages(
              any(),
              any(),
              any(),
            ),
          ).thenAnswer(
            (_) async => ['image1.jpg'],
          );

          final result = await recipeRepositoryImpl.updateRecipe(recipeEntity);

          expect(result.isSuccess(), true);
          expect(result.getOrNull(), isA<RecipeModel>());
          verify(
            () => recipeRemoteDatasource.updateRecipe(any()),
          ).called(1);
          verify(
            () => recipeRemoteDatasource.uploadImages(any(), any(), any()),
          ).called(1);
        },
      );

      test(
        'should return CustomException when the recipe update fails',
        () async {
          const exception = CustomException(
            messageError: 'Error updating recipe',
            customMessage: 'Erro ao atualizar receita',
          );
          when(() => recipeRemoteDatasource.updateRecipe(any())).thenAnswer(
            (_) async => const Result.failure(exception),
          );
          final result = await recipeRepositoryImpl.updateRecipe(recipeEntity);

          expect(result.isSuccess(), false);
          expect(result.getOrNull(), null);
          expect(result.isError(), true);
          expect(result.exceptionOrNull(), exception);
          verify(() => recipeRemoteDatasource.updateRecipe(any())).called(1);
          verifyNever(
            () => recipeRemoteDatasource.uploadImages(
              any(),
              any(),
              any(),
            ),
          );
        },
      );
    },
  );
}
