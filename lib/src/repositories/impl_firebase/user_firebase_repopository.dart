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

  CollectionReference get _usersCollection => _firebaseFirestore
      .collection(
        'users',
      )
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toMap(),
      );

  @override
  Future<Result<String, CustomException>> signInWithGoogle() async {
    final signInAccount = await _googleSignIn.signIn();
    if (signInAccount == null) {
      return Failure(
        LogInWithGoogleFailure.abortLogin(
          'sign_in_failed',
        ),
      );
    }
    try {
      final googleAuth = await signInAccount.authentication;
      final oAuthCredentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final result = await _firebaseAuth.signInWithCredential(oAuthCredentials);
      final userId = result.user!.uid;
      UserModel? userDoc = await _usersCollection.doc(userId).get().then(
        (doc) {
          if (doc.exists) {
            return UserModel.fromJson(doc.data() as Map<String, dynamic>);
          }
          return null;
        },
      );
      if (userDoc == null) {
        userDoc = UserModel(
          name: result.user!.displayName,
          id: userId,
          email: result.user!.email,
          photoUrl: result.user!.photoURL,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await _usersCollection.doc(userId).set(userDoc.toMap());
      }
      return Success(userId);
    } catch (e, s) {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        time: DateTime.now(),
      );
      if (e is FirebaseAuthException) {
        //final error = handleAuthError(e);
        return Failure(
          LogInWithGoogleFailure.fromFirebaseException(
            e,
          ),
        );
      }
      if (e is PlatformException) {
        return Failure(
          LogInWithGoogleFailure.abortLogin(
            e.code,
          ),
        );
      }
      if (e.runtimeType == String && e.toString() == 'popup_closed') {
        return Failure(
          LogInWithGoogleFailure.abortLogin(
            'popup_closed',
          ),
        );
      }
      return const Failure(
        LogInWithGoogleFailure(),
        // code: 'unknown_error',
        // message: 'Um erro desconhecido aconteceu. Tente novamente mais tarde',
      );
    }
  }
}
