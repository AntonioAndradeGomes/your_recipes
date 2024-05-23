import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipes/firebase_options.dart';
import 'package:your_recipes/providers.dart';
import 'package:your_recipes/src/app_widget.dart';
import 'package:your_recipes/src/common/routes/routes.dart';

import 'package:your_recipes/src/features/auth/domain/usecases/auth_state_changes.dart';
import 'package:your_recipes/src/features/auth/presentation/bloc/app_user/app_user_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  final appUserCubit = AppUserCubit(
    authStateChangesUseCase: getIt<AuthStateChanges>(),
  );
  final appRouter = AppRouter(appUserCubit);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => appUserCubit,
        ),
      ],
      child: AppWidget(
        appRouter: appRouter,
      ),
    ),
  );
}
