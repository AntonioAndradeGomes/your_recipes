import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:your_recipes/src/common/routes/routes_list.dart';
import 'package:your_recipes/src/common/routes/routes_location.dart';
import 'package:your_recipes/src/features/auth/presentation/bloc/app_user/app_user_cubit.dart';

final navigationKey = GlobalKey<NavigatorState>();

class AppRouter {
  final AppUserCubit _appUserCubit;

  AppRouter(
    this._appUserCubit,
  );

  late final GoRouter _router = GoRouter(
    initialLocation: RoutesLocation.splash,
    routes: routesList,
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
        return RoutesLocation.home;
      }
      if (isSplashPage && unauthenticatedUser) {
        return RoutesLocation.login;
      }

      if (isLoginPage && authenticatedUser) {
        return RoutesLocation.home;
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
