import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:your_recipes/src/config/routes/router_config.dart';
import 'package:your_recipes/src/config/theme/dimensions.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(
      const Duration(
        seconds: 3,
      ),
      () {
        context.pushReplacementNamed(
          RoutesLocation.login,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.orange.shade900,
                  Colors.orange.shade800,
                  Colors.orange.shade400
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.bowlFood,
                  color: Colors.white,
                  size: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Suas Receitas",
                  style: GoogleFonts.anton(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: Dimensions.paddingVerticalLarge,
              child: const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
