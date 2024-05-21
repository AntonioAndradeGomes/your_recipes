import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:your_recipes/src/config/theme/dimensions.dart';
import 'package:your_recipes/src/pages/login/widgets/logo_login_widget.dart';
import 'package:your_recipes/src/pages/login/widgets/social_button_widget.dart';
import 'package:your_recipes/src/viewmodels/user_view_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final usercontroller = context.watch<UserViewModel>();
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              padding: Dimensions.paddingAllMedium,
              child: Column(
                children: [
                  const LogoLoginWidget(),
                  Dimensions.verticalSpaceMedium,
                  FadeInUp(
                    duration: const Duration(
                      milliseconds: 1400,
                    ),
                    child: Form(
                      child: Column(
                        children: [
                          usercontroller.loading
                              ? const CircularProgressIndicator.adaptive()
                              : SocialButtonWidget(
                                  type: SocialMediaType.google,
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    final result =
                                        await usercontroller.signInWithGoogle();
                                    result.onFailure(
                                      (failure) {
                                        showAdaptiveDialog(
                                          context: context,
                                          builder: (_) => AlertDialog.adaptive(
                                            actions: [
                                              TextButton(
                                                onPressed: context.pop,
                                                child: const Text(
                                                  'Fechar',
                                                ),
                                              ),
                                            ],
                                            title: const Text(
                                              'Erro!',
                                            ),
                                            contentPadding:
                                                Dimensions.paddingAllLarge,
                                            content: Text(
                                              failure.customMessage!,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
