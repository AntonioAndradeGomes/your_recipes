import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:result_dart/result_dart.dart';
import 'package:your_recipes/src/error/custom_exception.dart';
import 'package:your_recipes/src/error/firebase_errors/login_with_google_failure.dart';
import 'package:your_recipes/src/models/user_model.dart';
import 'package:your_recipes/src/repositories/i_user_repository.dart';

class UserFirebaseRepopository implements IUserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firebaseFirestore;

  UserFirebaseRepopository(
    this._firebaseAuth,
    this._googleSignIn,
    this._firebaseFirestore,
  );

  CollectionReference get _usersCollection =>
      _firebaseFirestore.collection('users');

  @override
  Future<Result<UserModel, CustomException>> signInWithGoogle() async {
    try {
      final signInAccount = await _googleSignIn.signIn();
      if (signInAccount == null) {
        return Failure(
          LogInWithGoogleFailure.abortLogin('sign_in_failed'),
        );
      }
      final googleAuth = await signInAccount.authentication;
      final oAuthCredentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final result = await _firebaseAuth.signInWithCredential(oAuthCredentials);
      UserModel? userDoc = await _getUser(
        userId: result.user!.uid,
      );
      if (userDoc == null) {
        userDoc = UserModel(
          id: result.user!.uid,
          name: result.user!.displayName,
          email: result.user!.email,
          photoUrl: result.user!.photoURL,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await _usersCollection.doc(result.user!.uid).set(userDoc.toMap());
      }
      return Success(userDoc);
    } catch (e, s) {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        time: DateTime.now(),
      );
      if (e is FirebaseAuthException) {
        return Failure(
          LogInWithGoogleFailure.fromFirebaseException(e),
        );
      }
      if (e is PlatformException) {
        return Failure(
          LogInWithGoogleFailure.abortLogin(e.code),
        );
      }
      if (e.runtimeType == String && e.toString() == 'popup_closed') {
        return Failure(
          LogInWithGoogleFailure.abortLogin('popup_closed'),
        );
      }
      // code: 'unknown_error',
      // message: 'Um erro desconhecido aconteceu. Tente novamente mais tarde',
      return const Failure(LogInWithGoogleFailure());
    }
  }

  Future<UserModel?> _getUser({required String userId}) async {
    final doc = await _usersCollection.doc(userId).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }
}
