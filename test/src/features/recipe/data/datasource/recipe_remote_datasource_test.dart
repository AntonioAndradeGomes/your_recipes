import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:your_recipes/src/features/recipe/data/datasources/recipe_remote_datasource.dart';
import 'package:your_recipes/src/features/recipe/data/models/recipe_model.dart';

import '../repository/recipe_repository_impl_test.dart';

// Mocks usando mocktail
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockFirebaseStorage extends Mock implements FirebaseStorage {}

// ignore: subtype_of_sealed_class
class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

// ignore: subtype_of_sealed_class
class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockUser extends Mock implements User {}

class MockTaskSnapshot extends Mock implements TaskSnapshot {}

class MockReference extends Mock implements Reference {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockFirebaseStorage mockFirebaseStorage;
  late RecipeRemoteDatasource datasource;
  late MockCollectionReference mockCollectionReference;
  late MockDocumentReference mockDocumentReference;
  late MockUser mockUser;
  late MockTaskSnapshot mockTaskSnapshot;
  late MockReference mockReference;

  setUpAll(() {
    registerFallbackValue(FakeRecipeModel());
  });

  setUp(() {
    //mocks dos objetos do firebase
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseStorage = MockFirebaseStorage();
    mockFirebaseFirestore = MockFirebaseFirestore();
    //criando uma instância do datasource
    datasource = RecipeRemoteDatasourceImpl(
      auth: mockFirebaseAuth,
      firestore: mockFirebaseFirestore,
      storage: mockFirebaseStorage,
    );
    // Criando mocks específicos para Firestore
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    //mock do usuário do firebase
    mockUser = MockUser();
    // Mock de snapshot de tarefa
    mockTaskSnapshot = MockTaskSnapshot();
    // Mock de referência
    mockReference = MockReference();

    // Configurando comportamentos dos mocks
    when(() => mockFirebaseFirestore.collection(any()))
        .thenReturn(mockCollectionReference);
    when(() => mockCollectionReference.add(any()))
        .thenAnswer((_) async => mockDocumentReference);
    when(() => mockDocumentReference.id).thenReturn('recipeIdTeste');
  });

  group(
    'create recipe',
    () {
      test(
        'should return RecipeModel when the recipe is created sucessfully',
        () async {
          final recipeModel = RecipeModel(
            id: null,
            userId: null,
            name: 'Recipe',
            description: 'A delicious recipe',
            images: const [],
            newImages: const [],
            baseIngredients: const [],
            baseSteps: const [],
            portions: '4',
            preparationTime: '30 min',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
          when(() => mockUser.uid).thenReturn('user1');

          final result = await datasource.createRecipe(recipeModel);

          expect(result.isSuccess(), true);
          expect(result.getOrNull(), isA<RecipeModel>());
          final recipe = result.getOrNull();
          expect(recipe?.id, 'recipeIdTeste');
          expect(recipe?.userId, 'user1');
          verify(() => mockCollectionReference.add(any())).called(1);
        },
      );

      test(
        'should return failure when user is not authenticated',
        () async {},
      );
    },
  );
}
