import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:your_recipes/common/routes/routes_list.dart';
import 'package:your_recipes/common/routes/routes_location.dart';

final navigationKey = GlobalKey<NavigatorState>();

final routes = GoRouter(
  initialLocation: RoutesLocation.splash,
  routes: routesList,
);
