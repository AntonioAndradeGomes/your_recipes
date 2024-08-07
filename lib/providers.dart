import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
import 'package:your_recipes/src/features/recipe/data/datasources/recipe_remote_datasource.dart';
import 'package:your_recipes/src/features/recipe/data/repository/recipe_repository_impl.dart';
import 'package:your_recipes/src/features/recipe/domain/repository/recipe_repository.dart';
import 'package:your_recipes/src/features/recipe/domain/usecase/save_recipe_usecase.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/add_recipe/bloc/save_recipe_bloc.dart';
import 'package:your_recipes/src/features/user_profile/data/datasources/profile_remote_datasource.dart';
import 'package:your_recipes/src/features/user_profile/data/repository/profile_repository_impl.dart';
import 'package:your_recipes/src/features/user_profile/domain/usecases/get_user_usecase.dart';
import 'package:your_recipes/src/features/user_profile/domain/usecases/logout_user_usecase.dart';
import 'package:your_recipes/src/features/user_profile/presentation/bloc/profile/profile_bloc.dart';

import 'src/features/user_profile/domain/repository/profile_repository.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  //instances of firebase
  getIt.registerSingleton<FirebaseAuth>(
    FirebaseAuth.instance,
  );
  getIt.registerSingleton<FirebaseFirestore>(
    FirebaseFirestore.instance,
  );
  getIt.registerSingleton<GoogleSignIn>(
    GoogleSignIn.standard(),
  );

  getIt.registerSingleton<FirebaseStorage>(
    FirebaseStorage.instance,
  );

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
      auth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
      googleSignIn: getIt<GoogleSignIn>(),
    ),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      datasource: getIt<AuthDatasource>(),
    ),
  );

  getIt.registerLazySingleton<LoginWithGoogle>(
    () => LoginWithGoogle(
      repository: getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<AuthStateChanges>(
    () => AuthStateChanges(
      authRepository: getIt<AuthRepository>(),
    ),
  );

  getIt.registerFactory(
    () => LoginBloc(
      loginWithGoogleUseCase: getIt<LoginWithGoogle>(),
    ),
  );
  ////////////////////////////////////////////////

  //cadastro de receitas
  getIt.registerFactory(
    () => SaveRecipeBloc(
      saveRecipeUseCase: getIt<SaveRecipeUseCase>(),
    ),
  );

  getIt.registerLazySingleton(
    () => SaveRecipeUseCase(
      repository: getIt<RecipeRepository>(),
    ),
  );

  getIt.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(
      datasource: getIt<RecipeRemoteDatasource>(),
    ),
  );

  getIt.registerLazySingleton<RecipeRemoteDatasource>(
    () => RecipeRemoteDatasourceImpl(
      auth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
      storage: getIt<FirebaseStorage>(),
    ),
  );

  //perfil do usuário
  // Registrar ProfileRemoteDatasourceImp
  getIt.registerLazySingleton<ProfileRemoteDatasource>(
    () => ProfileRemoteDatasourceImp(
      auth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
      googleSignIn: getIt<GoogleSignIn>(),
    ),
  );

  // Registrar ProfileRepositoryImpl
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      datasource: getIt<ProfileRemoteDatasource>(),
    ),
  );
  //Registrar LogoutUseCase
  getIt.registerLazySingleton(
    () => LogoutUserUseCase(
      repository: getIt<ProfileRepository>(),
    ),
  );

  // Registrar GetUserUsecase
  getIt.registerLazySingleton(
    () => GetUserUsecase(
      repository: getIt<ProfileRepository>(),
    ),
  );

  // Registrar ProfileBloc
  getIt.registerLazySingleton(
    () => ProfileBloc(
      getUserUseCase: getIt<GetUserUsecase>(),
      logoutUserUseCase: getIt<LogoutUserUseCase>(),
    ),
  );
}
