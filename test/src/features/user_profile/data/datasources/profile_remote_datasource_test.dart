// ignore_for_file: subtype_of_sealed_class

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:your_recipes/src/features/auth/data/models/user_model.dart';
import 'package:your_recipes/src/features/user_profile/data/datasources/profile_remote_datasource.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockUser extends Mock implements User {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

void main() {
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore firebaseFirestore;
  late CollectionReference<Map<String, dynamic>> collectionReference;
  late DocumentReference<Map<String, dynamic>> documentReference;
  late ProfileRemoteDatasource datasource;
  late GoogleSignIn googleSignIn;

  // Configuração inicial dos mocks e da instância do datasource
  setUp(() {
    firebaseAuth = MockFirebaseAuth();
    firebaseFirestore = MockFirebaseFirestore();
    collectionReference = MockCollectionReference();
    documentReference = MockDocumentReference();
    googleSignIn = MockGoogleSignIn();
    datasource = ProfileRemoteDatasourceImp(
      auth: firebaseAuth,
      firestore: firebaseFirestore,
      googleSignIn: googleSignIn,
    );

    /// Configuração dos retornos esperados dos métodos dos mocks
    when(() => firebaseFirestore.collection(any()))
        .thenReturn(collectionReference);
    when(() => collectionReference.doc(any())).thenReturn(documentReference);
    when(() => documentReference.snapshots())
        .thenAnswer((_) => Stream.value(MockDocumentSnapshot()));
  });
  group(
    'Get Profile User',
    () {
      test(
        'should return a stream of UserModel when user is authenticated',
        () async {
          final user = MockUser();
          final documentSnapshot = MockDocumentSnapshot();

          when(() => firebaseAuth.authStateChanges())
              .thenAnswer((_) => Stream.value(user));
          when(() => user.uid).thenReturn('user1');
          when(() => documentReference.snapshots())
              .thenAnswer((_) => Stream.value(documentSnapshot));
          when(() => documentSnapshot.exists).thenReturn(true);
          when(() => documentSnapshot.id).thenReturn('user1');
          when(() => documentSnapshot.data()).thenReturn({
            'email': 'teste@teste.com',
            'name': 'Teste Testando',
            'photoUrl': 'imagem.com.br',
            'createdAt': Timestamp.now(),
            'updatedAt': Timestamp.now(),
            'provide': 'Google',
          });

          final result = datasource.authenticatedUserStream();

          expectLater(
            result,
            emitsInOrder(
              [
                predicate<UserModel>((userModel) {
                  expect(userModel.id, 'user1');
                  expect(userModel.email, 'teste@teste.com');
                  expect(userModel.name, 'Teste Testando');
                  expect(userModel.photoUrl, 'imagem.com.br');
                  expect(userModel.createdAt, isA<DateTime>());
                  expect(userModel.updatedAt, isA<DateTime>());
                  expect(userModel.provide, 'Google');
                  return true;
                })
              ],
            ),
          );
        },
      );

      test(
        'should return null when user is not authenticated',
        () async {
          when(() => firebaseAuth.authStateChanges())
              .thenAnswer((_) => Stream.value(null));

          final result = datasource.authenticatedUserStream();

          expectLater(result, emitsInOrder([null]));
        },
      );
    },
  );

  group(
    'SignOut',
    () {
      test(
        'should call signOut on GoogleSign and FirebaseAuth',
        () async {
          when(() => googleSignIn.signOut()).thenAnswer((_) async {
            return null;
          });
          when(() => firebaseAuth.signOut()).thenAnswer((_) async {
            return;
          });

          await datasource.logout();

          verify(() => googleSignIn.signOut()).called(1);
          verify(() => firebaseAuth.signOut()).called(1);
        },
      );
    },
  );
}
