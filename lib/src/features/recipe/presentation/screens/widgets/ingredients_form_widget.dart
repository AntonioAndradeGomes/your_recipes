import 'package:flutter/material.dart';
import 'package:your_recipes/src/common/widgets/custom_icon_button.dart';
import 'package:your_recipes/src/common/entities/ingredient_entity.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/widgets/edit_item_ingredient_widget.dart';

class IngredientsFormWidget extends StatelessWidget {
  final List<IngredientEntity> listIngredients;
  const IngredientsFormWidget({
    super.key,
    required this.listIngredients,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<List<IngredientEntity>>(
      initialValue: listIngredients,
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
                const Expanded(
                  child: Text(
                    'Ingredientes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CustomIconButton(
                  icon: Icons.add_rounded,
                  color: Theme.of(context).primaryColor,
                  onTap: () {
                    state.value?.add(
                      IngredientEntity(),
                    );
                    state.didChange(state.value);
                  },
                ),
              ],
            ),
            Column(
              children: state.value!
                  .map<Widget>(
                    (e) => EditItemIngredientWidget(
                      key: ObjectKey(e),
                      ingredientEntity: e,
                      onRemove: () {},
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
