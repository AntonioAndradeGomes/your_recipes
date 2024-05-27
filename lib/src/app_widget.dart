import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipes/src/common/routes/routes.dart';

import 'common/theme/theme.dart';

class AppWidget extends StatelessWidget {
  final AppRouter appRouter;
  const AppWidget({
    super.key,
    required this.appRouter,
  });

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
          routerDelegate: appRouter.router.routerDelegate,
          routeInformationParser: appRouter.router.routeInformationParser,
          routeInformationProvider: appRouter.router.routeInformationProvider,
        );
      },
    );
  }
}
