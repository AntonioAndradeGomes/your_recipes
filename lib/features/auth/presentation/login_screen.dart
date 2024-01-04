import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:your_recipes/common/theme/dimensions.dart';
import 'package:your_recipes/common/utils/extensions.dart';
import 'package:your_recipes/features/auth/presentation/widgets/social_button_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              padding: Dimensions.paddingAllMedium,
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
                    child: Column(
                      children: [
                        SocialButtonWidget(
                          type: SocialMediaType.google,
                          onPressed: () {},
                        ),
                        Dimensions.verticalSpaceMedium,
                        SocialButtonWidget(
                          type: SocialMediaType.apple,
                          onPressed: () {},
                        ),
                        Dimensions.verticalSpaceMedium,
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 400,
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                              labelText: 'Email',
                            ),
                          ),
                        ),
                        Dimensions.verticalSpaceMedium,
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 400,
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                              labelText: 'Senha',
                            ),
                          ),
                        ),
                        Dimensions.verticalSpaceSmallest,
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 400,
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Esqueceu sua senha?',
                              ),
                            ),
                          ),
                        ),
                        Dimensions.verticalSpaceMedium,
                        SizedBox(
                          width: 400,
                          height: 50,
                          child: FilledButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              elevation: 0,
                              iconColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Entrar',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                        Dimensions.verticalSpaceMedium,
                        SizedBox(
                          width: 400,
                          height: 50,
                          child: FilledButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              elevation: 0,
                              iconColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Cadastre-se',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ],
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
