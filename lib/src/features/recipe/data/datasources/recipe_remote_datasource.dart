import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';
import 'package:your_recipes/src/features/recipe/data/models/recipe_model.dart';

abstract class RecipeRemoteDatasource {
  Future<RecipeModel> createRecipe(RecipeModel recipeModel);
  Future<RecipeModel> updateRecipe(RecipeModel recipeModel);
  Future<List<String>> uploadImages(
    List<dynamic> newImages,
    List<String> oldImages,
    String recipeId,
  );
}

class RecipeRemoteDatasourceImpl extends RecipeRemoteDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  RecipeRemoteDatasourceImpl(
    this._firebaseAuth,
    this._firebaseFirestore,
    this._firebaseStorage,
  );

  CollectionReference get _recipeColletion => _firebaseFirestore.collection(
        'recipes',
      );

  @override
  Future<RecipeModel> createRecipe(RecipeModel recipeModel) async {
    log('buscado o user autenticado');
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw const CustomException(
        messageError: 'unauthenticated user',
        customMessage: 'Usuário não autenticado',
      );
    }
    recipeModel.userId = user.uid;
    log('criando receita: $recipeModel');
    final doc = await _recipeColletion.add(recipeModel.toMap());
    recipeModel.id = doc.id;
    return recipeModel;
    /*log('processo de adicionar imagens na receita $recipeModel');
    final updateImages = await _uploadImages(
      recipeModel.newImages ?? [],
      recipeModel.images ?? [],
      recipeModel.id!,
    );
    recipeModel.images = updateImages;
    return recipeModel;*/
  }

  @override
  Future<RecipeModel> updateRecipe(RecipeModel recipeModel) async {
    log('Atualizado dados da receita: $recipeModel');
    _recipeColletion.doc(recipeModel.id!).update(recipeModel.toMap());
    log('processo de adicionar imagens na receita $recipeModel');
    final updateImages = await _uploadImages(
      recipeModel.newImages ?? [],
      recipeModel.images ?? [],
      recipeModel.id!,
    );
    recipeModel.images = updateImages;
    return recipeModel;
  }

  Future<List<String>> _uploadImages(
    List<dynamic> newImages,
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

  @override
  Future<List<String>> uploadImages(
      List newImages, List<String> oldImages, String recipeId) {
    // TODO: implement uploadImages
    throw UnimplementedError();
  }
}
