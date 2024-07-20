import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:your_recipes/src/features/auth/data/models/user_model.dart';

abstract class ProfileRemoteDatasource {
  Stream<UserModel?> authenticatedUserStream();
}

class ProfileRemoteDatasourceImp implements ProfileRemoteDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  //final FirebaseStorage _firebaseStorage;

  ProfileRemoteDatasourceImp({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    //required FirebaseStorage storage,
  })  : _firebaseAuth = auth,
        _firebaseFirestore = firestore;
  //_firebaseStorage = storage;

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
}
