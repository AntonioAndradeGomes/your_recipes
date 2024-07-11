import 'package:flutter/material.dart';
import 'package:your_recipes/src/common/utils/extensions.dart';
import 'package:your_recipes/src/common/entities/recipe_entity.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/widgets/images_form_widget.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/widgets/ingredients_form_widget.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/widgets/steps_form_widget.dart';

class EditRecipePage extends StatefulWidget {
  final RecipeEntity recipeEntity;
  const EditRecipePage({
    super.key,
    required this.recipeEntity,
  });

  @override
  State<EditRecipePage> createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final textTheme = context.textTheme;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Criar Receita',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ImagesFormWidget(
                recipeEntity: widget.recipeEntity,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: widget.recipeEntity.name,
                      decoration: const InputDecoration(
                        hintText: 'Nome da receita',
                        // border: InputBorder.none,
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
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: widget.recipeEntity.description,
                      decoration: const InputDecoration(
                        hintText:
                            'Descrição: o que faz essa receita ser especial',
                        //border: InputBorder.none,
                      ),
                      style: textTheme.titleMedium,
                      maxLines: null,
                      onSaved: (value) {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: IngredientsFormWidget(
                  listIngredients: widget.recipeEntity.baseIngredients,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: StepsFormWidget(
                  listSteps: widget.recipeEntity.baseSteps,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
