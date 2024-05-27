import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:your_recipes/src/common/routes/routes_location.dart';
import 'package:your_recipes/src/features/auth/presentation/bloc/app_user/app_user_cubit.dart';
import 'package:your_recipes/src/features/auth/presentation/screens/login_screen.dart';
import 'package:your_recipes/src/features/base/presentation/screens/base_page.dart';
import 'package:your_recipes/src/features/home/presentation/screens/home_page.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/edit_recipe_page.dart';
import 'package:your_recipes/src/features/splash/presentation/screens/splash_screen.dart';

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
      ),
      GoRoute(
        path: RoutesLocation.login,
        name: RoutesLocation.login,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: RoutesLocation.editRecipe,
        name: RoutesLocation.editRecipe,
        builder: (context, state) {
          return EditRecipePage();
        },
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        pageBuilder: (context, state, child) {
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
                  title: Text(
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
                  title: Text(
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
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Perfil',
                  ),
                ),
              );
            },
          ),
        ],
      )
    ],
    redirect: (context, state) {
      final isLoadingUser = _appUserCubit.state is AppUserLoading;
      final authenticatedUser = _appUserCubit.state is AppUserAuthenticated;
      final unauthenticatedUser = _appUserCubit.state is AppUserUnauthenticated;
      final isSplashPage = state.fullPath == RoutesLocation.splash;
      final isLoginPage = state.fullPath == RoutesLocation.login;
      log('path: ${state.fullPath}');
      if (isSplashPage && isLoadingUser) {
        return null;
      }
      if (isSplashPage && authenticatedUser) {
        return RoutesLocation.base;
      }
      if (isSplashPage && unauthenticatedUser) {
        return RoutesLocation.login;
      }

      if (isLoginPage && authenticatedUser) {
        return RoutesLocation.base;
      }
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
