import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:your_recipes/src/features/auth/data/datasource/auth_datasource.dart';
import 'package:your_recipes/src/features/auth/data/datasource/firebase/auth_firebase_datasource.dart';
import 'package:your_recipes/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:your_recipes/src/features/auth/domain/repository/auth_repository.dart';
import 'package:your_recipes/src/features/auth/domain/usecases/auth_state_changes.dart';
import 'package:your_recipes/src/features/auth/domain/usecases/login_with_google.dart';
import 'package:your_recipes/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:your_recipes/src/features/image/data/datasource/images_datasource.dart';
import 'package:your_recipes/src/features/image/data/datasource/local/images_datasource_imp.dart';
import 'package:your_recipes/src/features/image/data/repository/images_repository_imp.dart';
import 'package:your_recipes/src/features/image/domain/repository/images_repository.dart';
import 'package:your_recipes/src/features/image/domain/usecases/get_image.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  //instances of firebase
  getIt.registerSingleton(
    FirebaseAuth.instance,
  );
  getIt.registerSingleton(
    FirebaseFirestore.instance,
  );
  getIt.registerSingleton(GoogleSignIn.standard());

  //instances of image
  getIt.registerSingleton(ImagePicker());

  getIt.registerSingleton(ImageCropper());

  getIt.registerLazySingleton<ImagesDatasource>(
    () => ImagesDatasourceImp(
      getIt<ImagePicker>(),
      getIt<ImageCropper>(),
    ),
  );

  getIt.registerLazySingleton<ImagesRepository>(
    () => ImagesRepositoryImp(
      getIt<ImagesDatasource>(),
    ),
  );

  getIt.registerLazySingleton<GetImage>(
    () => GetImage(
      getIt<ImagesRepository>(),
    ),
  );

  //auth

  getIt.registerLazySingleton<AuthDatasource>(
    () => AuthFirebaseDatasource(
      getIt<FirebaseAuth>(),
      getIt<FirebaseFirestore>(),
      getIt<GoogleSignIn>(),
    ),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthDatasource>(),
    ),
  );

  getIt.registerLazySingleton<LoginWithGoogle>(
    () => LoginWithGoogle(
      getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<AuthStateChanges>(
    () => AuthStateChanges(
      getIt<AuthRepository>(),
    ),
  );

  getIt.registerFactory(
    () => LoginBloc(
      loginWithGoogleUseCase: getIt<LoginWithGoogle>(),
    ),
  );
  ////////////////////////////////////////////////
}
