import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:your_recipes/src/pages/login/login_page.dart';
import 'package:your_recipes/src/pages/splash/splash_page.dart';
import 'package:your_recipes/src/providers.dart';

abstract class RoutesLocation {
  static String get splash => '/splash';
  static String get login => '/login';
  static String get signup => '/signup';
  static String get profile => '/profile';
}

final routesList = [
  GoRoute(
    path: RoutesLocation.splash,
    name: RoutesLocation.splash,
    builder: (context, state) {
      return const SplashPage();
    },
  ),
  GoRoute(
    path: RoutesLocation.login,
    name: RoutesLocation.login,
    builder: (context, state) {
      return const LoginPage();
    },
  ),
  GoRoute(
    path: RoutesLocation.signup,
    name: RoutesLocation.signup,
    builder: (context, state) {
      return const Scaffold();
    },
  ),
  GoRoute(
    path: RoutesLocation.profile,
    name: RoutesLocation.profile,
    builder: (context, state) {
      return const Scaffold();
    },
  ),
];

final navigationKey = GlobalKey<NavigatorState>();

final routes = GoRouter(
  initialLocation: RoutesLocation.splash,
  routes: routesList,
  refreshListenable: userController,
  redirect: (context, state) {
    final usercontroller = userController.user;
    print(usercontroller);
    print(state.fullPath);
    return null;
    /*final isSplash = state.fullPath == RoutesLocation.splash;
    if (isSplash) {
      return RoutesLocation.login;
    }
    final isLoggedIn = state.fullPath == RoutesLocation.login;
    if (isLoggedIn) {
      return null;
    }*/
  },
);
