import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:your_recipes/src/common/utils/extensions.dart';
import 'package:your_recipes/src/common/entities/recipe_entity.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/widgets/images_form_widget.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/widgets/ingredients_form_widget.dart';

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
  final _form1Key = GlobalKey<FormState>();
  final _form2Key = GlobalKey<FormState>();
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
      body: ListView(
        children: [
          Form(
            key: _form1Key,
            child: Column(
              children: [
                ImagesFormWidget(
                  recipeEntity: widget.recipeEntity,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
              ],
            ),
          ),
          Form(
            key: _form2Key,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              child: IngredientsFormWidget(
                listIngredients: widget.recipeEntity.baseIngredients,
              ),
            ),
          ),
          Center(
            child: FilledButton(
              onPressed: () {
                _form1Key.currentState!.validate();
                _form2Key.currentState!.validate();
              },
              child: const Text(
                'Salvar',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
