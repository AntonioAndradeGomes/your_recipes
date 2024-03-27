import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:your_recipes/src/config/extensions.dart';
import 'package:your_recipes/src/config/theme/dimensions.dart';

class LogoLoginWidget extends StatelessWidget {
  const LogoLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return FadeInUp(
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
    );
  }
}
