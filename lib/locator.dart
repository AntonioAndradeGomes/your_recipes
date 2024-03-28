import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:your_recipes/src/repositories/i_user_repository.dart';
import 'package:your_recipes/src/repositories/impl_firebase/user_firebase_repopository.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  //instances of firebase
  locator.registerSingleton(
    FirebaseAuth.instance,
  );
  locator.registerSingleton(
    FirebaseFirestore.instance,
  );
  locator.registerSingleton(
    GoogleSignIn.standard(),
  );
  //repositories globals
  locator.registerSingleton<IUserRepository>(
    UserFirebaseRepopository(
      locator(),
      locator(),
      locator(),
    ),
  );
}
