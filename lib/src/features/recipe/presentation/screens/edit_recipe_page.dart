import 'package:flutter/material.dart';
import 'package:your_recipes/src/common/theme/dimensions.dart';
import 'package:your_recipes/src/common/utils/extensions.dart';
import 'package:your_recipes/src/features/recipe/domain/entities/recipe_entity.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/widgets/images_form_widget.dart';

class EditRecipePage extends StatefulWidget {
  const EditRecipePage({super.key});

  @override
  State<EditRecipePage> createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  RecipeEntity recipeEntity = const RecipeEntity(
    name: 'Bolo de cenoura',
    imagens: [
      'https://imagem.band.com.br/novahome/055caa6d-7528-44bc-ac32-3add84bdc0b0.jpg',
    ],
  );
  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final textTheme = context.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Criar Receita',
        ),
      ),
      body: Form(
        child: ListView(
          children: [
            ImagesFormWidget(
              recipeEntity: recipeEntity,
            ),
            Padding(
              padding: Dimensions.paddingHorizontalMedium,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: recipeEntity.name,
                    decoration: const InputDecoration(
                      hintText: 'Nome da receita',
                      border: InputBorder.none,
                    ),
                    style: textTheme.titleLarge!.copyWith(
                      color: colors.primaryContainer,
                      fontWeight: FontWeight.w800,
                    ),
                    onSaved: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      if (value.length < 6) {
                        return "Título muito curto";
                      }
                      return null;
                    },
                  ),
                  Dimensions.verticalSpaceSmallest,
                  Text(
                    'Descrição',
                    style: textTheme.titleMedium,
                  ),
                  Dimensions.verticalSpaceSmallest,
                  TextFormField(
                    initialValue: recipeEntity.description,
                    decoration: const InputDecoration(
                      hintText: 'Descrição',
                      border: InputBorder.none,
                    ),
                    style: textTheme.titleMedium,
                    maxLines: null,
                    onSaved: (value) {},
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
