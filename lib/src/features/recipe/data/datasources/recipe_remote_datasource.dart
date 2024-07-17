import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:result_dart/result_dart.dart';
import 'package:uuid/uuid.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';
import 'package:your_recipes/src/features/recipe/data/models/recipe_model.dart';

abstract class RecipeRemoteDatasource {
  Future<Result<RecipeModel, CustomException>> createRecipe(
    RecipeModel recipeModel,
  );
  Future<Result<RecipeModel, CustomException>> updateRecipe(
    RecipeModel recipeModel,
  );
  Future<List<String>> uploadImages(
    List<dynamic> newImages,
    List<String> oldImages,
    String recipeId,
  );
}

class RecipeRemoteDatasourceImpl implements RecipeRemoteDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  RecipeRemoteDatasourceImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _firebaseAuth = auth,
        _firebaseFirestore = firestore,
        _firebaseStorage = storage;

  CollectionReference get _recipeColletion => _firebaseFirestore.collection(
        'recipes',
      );

  Future<User?> _getAuthenticatedUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw const CustomException(
        messageError: 'unauthenticated user',
        customMessage: 'Usuário não autenticado',
      );
    }
    return user;
  }

  @override
  Future<Result<RecipeModel, CustomException>> createRecipe(
    RecipeModel recipeModel,
  ) async {
    // Obtém o usuário autenticado
    log('Buscando o ID do usuário autenticado');
    final user = await _getAuthenticatedUser();
    if (user == null) {
      return const Result.failure(
        CustomException(
          messageError: 'unauthenticated user',
          customMessage: 'Usuário não autenticado',
        ),
      );
    }
    // Atribui o ID do usuário à receita
    recipeModel.userId = user.uid;
    log('Tentando cadastrar a receita: $recipeModel');
    try {
      // Adiciona a receita ao Firestore
      final doc = await _recipeColletion.add(recipeModel.toMap());
      recipeModel.id = doc.id;
      return Result.success(recipeModel);
    } catch (e, s) {
      log(
        'Erro no cadastro de receita: ${e.toString()}',
        error: e,
        stackTrace: s,
        time: DateTime.now(),
      );
      return Result.failure(
        CustomException(
          messageError: e.toString(),
          customMessage: 'Erro no cadastro da receita',
        ),
      );
    }
  }

  @override
  Future<Result<RecipeModel, CustomException>> updateRecipe(
    RecipeModel recipeModel,
  ) async {
    log('Tentando atualizar dados da receita: $recipeModel');
    try {
      recipeModel.updatedAt = DateTime.now();
      await _recipeColletion.doc(recipeModel.id).update(recipeModel.toMap());
      return Result.success(recipeModel);
    } catch (e, s) {
      log(
        'Erro na atualização de receita: ${e.toString()}',
        error: e,
        stackTrace: s,
        time: DateTime.now(),
      );
      return Result.failure(
        CustomException(
          messageError: e.toString(),
          customMessage: 'Erro na atualização da receita',
        ),
      );
    }
  }

  @override
  Future<List<String>> uploadImages(
    List newImages,
    List<String> oldImages,
    String recipeId,
  ) async {
    final List<String> updateImages = [];
    //percorrer a lista de imagens
    for (final newImage in newImages) {
      if (oldImages.contains(newImage)) {
        //adicionas as imagens atualizadas a imagem que ja tem
        updateImages.add(newImage);
      } else {
        //se a imagem ainda não está no firebase
        final ref = _firebaseStorage
            .ref()
            .child('recipes')
            .child(recipeId)
            .child(const Uuid().v1());
        final task = await ref.putFile(newImage as File);
        //se houve sucesso ao enviar a imagem
        if (task.state == TaskState.success) {
          final url = await ref.getDownloadURL();
          updateImages.add(url);
        }
      }
    }

    //processo para deletar as imagens que não serão mais utilizadas
    for (final image in oldImages) {
      if (!newImages.contains(image) && image.contains('firebase')) {
        try {
          //tentar buscar a referencia no storage da imagem e deletar
          final ref = _firebaseStorage.refFromURL(image);
          await ref.delete();
        } catch (e, s) {
          log(
            'Falha ao deletar a imagem: $image',
            error: e,
            stackTrace: s,
            time: DateTime.now(),
          );
        }
      }
    }
    log('Novas imagens: $updateImages');
    log('Colocar no firebase');
    await _recipeColletion.doc(recipeId).update(
      {
        'images': updateImages,
      },
    );

    return updateImages;
  }
}
