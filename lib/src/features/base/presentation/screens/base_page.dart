import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:your_recipes/src/common/routes/routes.dart';
import 'package:your_recipes/src/features/auth/presentation/bloc/app_user/app_user_cubit.dart';
import 'package:your_recipes/src/features/recipe/domain/entities/recipe_entity.dart';
import 'widgets/custom_bottom_app_bar_widget.dart';
import 'widgets/icon_botton_bar_widget.dart';

class BasePage extends StatelessWidget {
  final String? location;
  final Widget child;
  const BasePage({
    super.key,
    this.location,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserCubit, AppUserState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: child,
          ),
          bottomNavigationBar: CustomBottomAppBarWidget(
            selectedButton: TypeButton.values.firstWhere(
              (element) => element.path == location,
            ),
            onChanged: (value) {
              context.go(value.path, extra: state.userEntity);
            },
            onPressedAddRecipe: () {
              context.pushNamed(
                RoutesLocation.editRecipe,
                extra: RecipeEntity.empty(),
              );
            },
          ),
        );
      },
    );
  }
}
