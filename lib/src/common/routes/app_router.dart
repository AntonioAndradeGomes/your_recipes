import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:your_recipes/src/common/routes/routes_location.dart';
import 'package:your_recipes/src/features/auth/domain/entities/user_entity.dart';
import 'package:your_recipes/src/features/auth/presentation/bloc/app_user/app_user_cubit.dart';
import 'package:your_recipes/src/features/auth/presentation/screens/login_screen.dart';
import 'package:your_recipes/src/features/base/presentation/screens/base_page.dart';
import 'package:your_recipes/src/features/home/presentation/screens/home_page.dart';
import 'package:your_recipes/src/features/recipe/domain/entities/recipe_entity.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/add_recipe/edit_recipe_page.dart';
import 'package:your_recipes/src/features/splash/presentation/screens/splash_screen.dart';
import 'package:your_recipes/src/features/user_profile/presentation/screens/edit_profile_screen.dart';
import 'package:your_recipes/src/features/user_profile/presentation/screens/profile_screen.dart';

final navigationKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  final AppUserCubit _appUserCubit;

  AppRouter(
    this._appUserCubit,
  );

  late final GoRouter _router = GoRouter(
    initialLocation: RoutesLocation.splash,
    navigatorKey: navigationKey,
    routes: [
      GoRoute(
        path: RoutesLocation.splash,
        name: RoutesLocation.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
        redirect: (context, state) {
          final isLoadingUser = _appUserCubit.state is AppUserLoading;
          final authenticatedUser = _appUserCubit.state is AppUserAuthenticated;
          final unauthenticatedUser =
              _appUserCubit.state is AppUserUnauthenticated;
          if (isLoadingUser) {
            return null;
          }
          if (authenticatedUser) {
            return RoutesLocation.base;
          }
          if (unauthenticatedUser) {
            return RoutesLocation.login;
          }
          return null;
        },
      ),
      GoRoute(
        path: RoutesLocation.editProfile,
        name: RoutesLocation.editProfile,
        builder: (context, state) {
          final user = state.extra as UserEntity;
          return EditProfileScreen(
            userEntity: user,
          );
        },
        redirect: (context, state) {
          final unauthenticatedUser =
              _appUserCubit.state is AppUserUnauthenticated;
          if (unauthenticatedUser) {
            return RoutesLocation.splash;
          }
          return null;
        },
      ),
      GoRoute(
        path: RoutesLocation.login,
        name: RoutesLocation.login,
        builder: (context, state) {
          return const LoginScreen();
        },
        redirect: (context, state) {
          final authenticatedUser = _appUserCubit.state is AppUserAuthenticated;
          if (authenticatedUser) {
            return RoutesLocation.base;
          }
          return null;
        },
      ),
      GoRoute(
        path: RoutesLocation.editRecipe,
        name: RoutesLocation.editRecipe,
        builder: (context, state) {
          final recipe = state.extra as RecipeEntity;
          return EditRecipePage(
            recipeEntity: recipe,
          );
        },
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        pageBuilder: (_, state, child) {
          return NoTransitionPage(
            child: BasePage(
              location: state.fullPath,
              child: child,
            ),
          );
        },
        routes: [
          GoRoute(
            path: RoutesLocation.base,
            name: RoutesLocation.base,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) {
              return const HomePage();
            },
          ),
          GoRoute(
            path: RoutesLocation.search,
            name: RoutesLocation.search,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Buscar',
                  ),
                ),
              );
            },
          ),
          GoRoute(
            path: RoutesLocation.favorite,
            name: RoutesLocation.favorite,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Favoritos',
                  ),
                ),
              );
            },
          ),
          GoRoute(
            path: RoutesLocation.profile,
            name: RoutesLocation.profile,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) {
              return const ProfileScreen();
            },
            redirect: (context, state) {
              final unauthenticatedUser =
                  _appUserCubit.state is AppUserUnauthenticated;

              if (unauthenticatedUser) {
                return RoutesLocation.splash;
              }
              return null;
            },
          ),
        ],
      )
    ],
    redirect: (context, state) {
      log('rota: ${state.fullPath}');
      return null;
    },
    refreshListenable: GoRouterRefreshStream(
      _appUserCubit.stream,
    ),
  );

  GoRouter get router => _router;
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    stream.listen((event) {
      notifyListeners();
    });
  }
}
