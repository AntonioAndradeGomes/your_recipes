import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipes/common/common.dart';
import 'package:your_recipes/common/routes/router_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      splitScreenMode: false,
      minTextAdapt: true,
      builder: (_, __) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Your Recipes',
          theme: AppTheme.ligth.copyWith(
            appBarTheme: const AppBarTheme(
              centerTitle: true,
            ),
          ),
          routerDelegate: routes.routerDelegate,
          routeInformationParser: routes.routeInformationParser,
          routeInformationProvider: routes.routeInformationProvider,
        );
      },
    );
  }
}
