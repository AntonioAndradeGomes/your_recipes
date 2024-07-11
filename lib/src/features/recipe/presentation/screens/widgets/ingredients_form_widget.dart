import 'package:flutter/material.dart';
import 'package:your_recipes/src/common/helpers/ingredient_helper.dart';
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
      initialValue: listIngredients ??
          [
            IngredientEntity(),
            IngredientEntity(),
          ],
      validator: (items) {
        if (items == null || items.isEmpty) {
          return "A receita deve ter ao menos 1 ingrediente";
        }
        return null;
      },
      builder: (state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
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
                      IngredientEntity(),
                    );
                    state.didChange(state.value);
                  },
                ),
              ],
            ),
            if (state.value != null)
              Column(
                children: state.value!.map<Widget>(
                  (item) {
                    return EditItemIngredientWidget(
                      key: ObjectKey(item),
                      ingredientEntity: item,
                      onRemove: () {
                        state.value?.remove(item);
                        state.didChange(state.value);
                      },
                      hintTextExample: IngredientHelper.getRandomIngredient(),
                      onMoveUp: item != state.value!.first
                          ? () {
                              final index = state.value!.indexOf(item);
                              state.value?.remove(item);
                              state.value?.insert(index - 1, item);
                              state.didChange(state.value);
                            }
                          : null,
                      onMoveDown: item != state.value!.last
                          ? () {
                              final index = state.value!.indexOf(item);
                              state.value?.remove(item);
                              state.value?.insert(index + 1, item);
                              state.didChange(state.value);
                            }
                          : null,
                    );
                  },
                ).toList(),
              ),
            /*Expanded(
                child: ReorderableListView.builder(
                  itemCount: state.value!.length,
                  shrinkWrap: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = state.value![index];
                    return EditItemIngredientWidget(
                      key: ObjectKey(item),
                      ingredientEntity: item,
                      onRemove: () {
                        state.value?.remove(item);
                        state.didChange(state.value);
                      },
                    );
                  },
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) newIndex -= 1;
                    final item = state.value!.removeAt(oldIndex);
                    state.value!.insert(newIndex, item);
                    state.didChange(state.value);
                  },
                ),
              ),*/
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
