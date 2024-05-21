import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipes/src/config/routes/router_config.dart';
import 'package:your_recipes/src/config/theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      splitScreenMode: false,
      minTextAdapt: true,
      builder: (context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Your Recipes',
          theme: AppTheme.ligth.copyWith(
            appBarTheme: const AppBarTheme(
              centerTitle: true,
            ),
          ),
          themeMode: ThemeMode.light,
          routerDelegate: routes.routerDelegate,
          routeInformationParser: routes.routeInformationParser,
          routeInformationProvider: routes.routeInformationProvider,
        );
      },
    );
  }
}
