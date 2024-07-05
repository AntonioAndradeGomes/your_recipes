import 'package:flutter/material.dart';
import 'package:your_recipes/src/common/utils/extensions.dart';
import 'package:your_recipes/src/common/widgets/custom_icon_button.dart';
import 'package:your_recipes/src/common/entities/ingredient_entity.dart';

import 'package:your_recipes/src/features/recipe/presentation/screens/widgets/edit_item_ingredient_widget.dart';

class IngredientsFormWidget extends StatelessWidget {
  final List<IngredientEntity>? listIngredients;
  const IngredientsFormWidget({
    super.key,
    required this.listIngredients,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return FormField<List<IngredientEntity>>(
      // autovalidateMode: AutovalidateMode.always,
      initialValue: listIngredients ??
          [
            IngredientEntity(
              pos: 0,
            ),
            IngredientEntity(
              pos: 1,
            ),
          ],
      validator: (items) {
        if (items == null || items.isEmpty) {
          return "A receita deve ter ao menos 1 ingrediente";
        }
        return null;
      },
      builder: (state) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Ingredientes',
                    style: textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CustomIconButton(
                  icon: Icons.add_rounded,
                  color: Theme.of(context).primaryColor,
                  onTap: () {
                    state.value?.add(
                      IngredientEntity(
                        pos: state.value?.length,
                      ),
                    );
                    state.didChange(state.value);
                  },
                ),
              ],
            ),
            Column(
              children: state.value!.map<Widget>((item) {
                return EditItemIngredientWidget(
                  key: ObjectKey(item),
                  ingredientEntity: item,
                  onRemove: () {
                    state.value?.remove(item);
                    state.didChange(state.value);
                  },
                );
              }).toList(),
            ),
            if (state.hasError)
              Container(
                margin: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
