import 'package:get_it/get_it.dart';
import 'package:your_recipes/features/auth/presentation/cubit/login_cubit.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(),
  );
}
