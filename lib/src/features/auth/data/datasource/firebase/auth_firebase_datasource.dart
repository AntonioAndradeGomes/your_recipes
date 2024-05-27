import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:your_recipes/src/features/auth/data/datasource/auth_datasource.dart';
import 'package:your_recipes/src/features/auth/data/models/user_model.dart';

class AuthFirebaseDatasource extends AuthDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final GoogleSignIn _googleSignIn;

  AuthFirebaseDatasource(
    this._firebaseAuth,
    this._firebaseFirestore,
    this._googleSignIn,
  );

  CollectionReference get _usersCollection => _firebaseFirestore.collection(
        'users',
      );

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final signInAccount = await _googleSignIn.signIn();
      if (signInAccount == null) {
        throw PlatformException(
          code: 'sign_in_failed',
          message: 'Processo de login abortado',
        );
      }
      final googleAuth = await signInAccount.authentication;
      final oAuthCredentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final result = await _firebaseAuth.signInWithCredential(oAuthCredentials);
      final userId = result.user!.uid;
      final userDoc = await _usersCollection.doc(userId).get();
      if (userDoc.exists) {
        final json = userDoc.data() as Map<String, dynamic>;
        json.addAll({'id': userDoc.id});
        return UserModel.fromJson(json);
      }
      return _createUser(result.user!);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<UserModel> _createUser(User user) async {
    final userModel = UserModel(
      id: user.uid,
      email: user.email!,
      name: user.displayName!,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      provide: 'Google',
      photoUrl: user.photoURL,
    );
    await _usersCollection.doc(user.uid).set(userModel.toMap());
    return userModel;
  }

  @override
  Stream<UserModel?> authStateChanges() {
    return _firebaseAuth.authStateChanges().asyncMap((user) async {
      if (user == null) {
        return null;
      }
      final doc = await _usersCollection.doc(user.uid).get();
      final json = doc.data() as Map<String, dynamic>;
      json.addAll({'id': doc.id});
      return UserModel.fromJson(json);
    });
  }
}
