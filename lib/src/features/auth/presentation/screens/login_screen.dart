import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:your_recipes/providers.dart';
import 'package:your_recipes/src/common/theme/dimensions.dart';
import 'package:your_recipes/src/common/utils/extensions.dart';
import 'package:your_recipes/src/features/auth/presentation/bloc/login/login_bloc.dart';

import 'package:your_recipes/src/features/auth/presentation/widgets/social_button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = getIt<LoginBloc>();
  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return BlocProvider<LoginBloc>(
      create: (context) => _controller,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                FadeInUp(
                  duration: const Duration(
                    milliseconds: 1000,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.bowlFood,
                        color: colors.primary,
                        size: Dimensions.iconSizeLarger,
                      ),
                      Dimensions.verticalSpaceSmaller,
                      Text(
                        "Suas Receitas",
                        style: GoogleFonts.anton(
                          color: colors.primary,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Dimensions.verticalSpaceMedium,
                FadeInUp(
                  duration: const Duration(
                    milliseconds: 1400,
                  ),
                  child: BlocConsumer<LoginBloc, LoginState>(
                    listener: (_, state) {
                      if (state is LoginError) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog.adaptive(
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Fechar',
                                ),
                              ),
                            ],
                            title: const Text(
                              'Erro!',
                            ),
                            contentPadding: Dimensions.paddingAllLarge,
                            content: Text(
                              state.customException!.customMessage!,
                            ),
                          ),
                        );
                      }
                    },
                    builder: (_, state) {
                      if (state is LoginLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
                        children: [
                          SocialButtonWidget(
                            type: SocialMediaType.google,
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              _controller.add(
                                LoginGoogleSignUp(),
                              );
                            },
                          ),
                          Dimensions.verticalSpaceMedium,
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
