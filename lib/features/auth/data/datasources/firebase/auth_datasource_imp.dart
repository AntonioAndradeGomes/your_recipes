import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:your_recipes/features/auth/data/datasources/auth_datasource.dart';

class AuthDatasourceImp implements AuthDatasource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FirebaseFirestore firebaseFirestore;

  AuthDatasourceImp({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.firebaseFirestore,
  });

  CollectionReference get _usersCollection => firebaseFirestore.collection(
        'users',
      );

  @override
  Future<String> signInGoogle() async {
    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      throw PlatformException(
        code: 'sign_in_failed',
        message: 'Processo de login abortado',
      );
    } else {
      try {
        final googleAuth = await signInAccount.authentication;
        final oAuthCredentials = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final result =
            await firebaseAuth.signInWithCredential(oAuthCredentials);
        final userId = result.user!.uid;
        final userDoc = await _usersCollection.doc(userId).get();
        if (!userDoc.exists) {
          await _usersCollection.doc(userId).set({
            'displayName': result.user?.displayName,
            'email': result.user?.email,
            'imageUrl': result.user?.photoURL,
            'userId': userId,
          });
        }
        return userId;
      } catch (e) {
        rethrow;
      }
    }
  }
}
