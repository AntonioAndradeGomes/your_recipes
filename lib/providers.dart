import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:your_recipes/features/auth/data/datasources/auth_datasource.dart';
import 'package:your_recipes/features/auth/data/datasources/firebase/auth_datasource_imp.dart';
import 'package:your_recipes/features/auth/data/repository/auth_repository_imp.dart';
import 'package:your_recipes/features/auth/domain/repository/auth_repository.dart';
import 'package:your_recipes/features/auth/domain/usecases/auth_changes/auth_changes_usecase.dart';
import 'package:your_recipes/features/auth/domain/usecases/login_with_google/login_with_google_usecase.dart';
import 'package:your_recipes/features/auth/presentation/cubit/auth_changes/auth_changes_cubit.dart';
import 'package:your_recipes/features/auth/presentation/cubit/login/login_cubit.dart';

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
  ////////////////////////////////////////////////

  //login
  getIt.registerLazySingleton<AuthDatasource>(
    () => AuthDatasourceImp(
      firebaseAuth: getIt(),
      googleSignIn: getIt(),
      firebaseFirestore: getIt(),
    ),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(
      datasource: getIt(),
    ),
  );

  getIt.registerLazySingleton<LoginWithGoogleUsecase>(
    () => LoginWithGoogleUsecaseImp(
      repository: getIt(),
    ),
  );

  getIt.registerLazySingleton<AuthChangesUsecase>(
    () => AuthChangesUsecaseImp(
      repository: getIt(),
    ),
  );

  getIt.registerSingleton<AuthChangesCubit>(
    AuthChangesCubit(
      usecase: getIt(),
    ),
  );

  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(
      loginWithGoogleUsecase: getIt(),
    ),
  );
  ///////////////////////////////////////////////////////////
}
