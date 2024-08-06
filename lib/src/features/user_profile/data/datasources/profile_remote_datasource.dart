import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:your_recipes/src/features/auth/data/models/user_model.dart';

abstract class ProfileRemoteDatasource {
  Stream<UserModel?> authenticatedUserStream();
  Future<void> logout();
}

class ProfileRemoteDatasourceImp implements ProfileRemoteDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final GoogleSignIn _googleSignIn;

  ProfileRemoteDatasourceImp({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required GoogleSignIn googleSignIn,
  })  : _firebaseAuth = auth,
        _firebaseFirestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _usersCollection => _firebaseFirestore.collection(
        'users',
      );

  @override
  Stream<UserModel?> authenticatedUserStream() {
    return _firebaseAuth.authStateChanges().asyncExpand(
      (firebaseUser) {
        if (firebaseUser == null) {
          return Stream.value(null);
        }
        return _usersCollection.doc(firebaseUser.uid).snapshots().map(
          (doc) {
            if (doc.exists) {
              final json = doc.data() as Map<String, dynamic>;
              json.addAll({'id': doc.id});
              return UserModel.fromJson(json);
            }
            return null;
          },
        );
      },
    );
  }

  @override
  Future<void> logout() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
