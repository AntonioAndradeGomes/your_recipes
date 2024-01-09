import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:your_recipes/common/routes/routes_list.dart';
import 'package:your_recipes/common/routes/routes_location.dart';
import 'package:your_recipes/features/auth/presentation/cubit/auth_changes/auth_changes_cubit.dart';
import 'package:your_recipes/providers.dart';

final navigationKey = GlobalKey<NavigatorState>();

final routes = GoRouter(
  initialLocation: RoutesLocation.splash,
  routes: routesList,
  redirect: (context, state) {
    final authChanges = getIt.get<AuthChangesCubit>();
    print(authChanges.state);
    print(state.fullPath);
    final isSplash = state.fullPath == RoutesLocation.splash;
    if (isSplash) {
      return RoutesLocation.login;
    }
    final isLoggedIn = state.fullPath == RoutesLocation.login;
    if (isLoggedIn) {
      return null;
    }
  },
);
