import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:your_recipes/src/common/utils/extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Suas Receitas",
          style: GoogleFonts.anton(
            color: colors.primary,
            fontSize: 30,
          ),
        ),
      ),
      body: const Column(),
    );
  }
}
