import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:your_recipes/common/routes/routes_location.dart';
import 'package:your_recipes/features/auth/presentation/login_screen.dart';
import 'package:your_recipes/features/splash/presentation/splash_screen.dart';

final routesList = [
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
