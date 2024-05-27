import 'package:flutter/material.dart';
import 'package:your_recipes/src/features/recipe/domain/entities/recipe_entity.dart';

class EditRecipePage extends StatefulWidget {
  const EditRecipePage({super.key});

  @override
  State<EditRecipePage> createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  RecipeEntity recipeEntity = RecipeEntity(
    name: '',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Criar Receita',
        ),
      ),
      body: Form(
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
