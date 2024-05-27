import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:your_recipes/src/common/routes/routes.dart';
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
    return Scaffold(
      body: SafeArea(
        child: child,
      ),
      bottomNavigationBar: CustomBottomAppBarWidget(
        selectedButton: TypeButton.values.firstWhere(
          (element) => element.path == location,
        ),
        onChanged: (value) {
          context.go(value.path);
        },
        onPressedAddRecipe: () {
          context.pushNamed(RoutesLocation.editRecipe);
        },
      ),
    );
  }
}
