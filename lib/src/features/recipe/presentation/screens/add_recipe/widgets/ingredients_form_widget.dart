import 'package:flutter/material.dart';
import 'package:your_recipes/src/common/entities/ingredient_section_entity.dart';
import 'package:your_recipes/src/common/utils/extensions.dart';
import 'package:your_recipes/src/common/entities/ingredient_entity.dart';

import 'package:your_recipes/src/features/recipe/presentation/screens/add_recipe/widgets/edit_item_ingredient_widget.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/add_recipe/widgets/section_ingredients_form_widget.dart';

class IngredientsFormWidget extends StatelessWidget {
  final List<dynamic>? listIngredients;
  final ScrollController pageListScrollController;

  const IngredientsFormWidget({
    super.key,
    required this.listIngredients,
    required this.pageListScrollController,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return FormField<List<dynamic>>(
      initialValue: listIngredients,
      validator: (items) {
        if (items == null || items.isEmpty) {
          return "A receita deve ter ao menos 1 ingrediente";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Ingredientes',
              style: textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (state.value != null)
              Column(
                children: state.value!.map<Widget>(
                  (item) {
                    if (item is IngredientEntity) {
                      return EditItemIngredientWidget(
                        key: ObjectKey(item),
                        ingredientEntity: item,
                        onRemove: () {
                          FocusScope.of(context).unfocus();
                          state.value?.remove(item);
                          state.didChange(state.value);
                        },
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
                    }
                    if (item is IngredientSectionEntity) {
                      return SectionIngredientsFormWidget(
                        ingredientSectionEntity: item,
                        pageListScrollController: pageListScrollController,
                        onRemove: () {
                          FocusScope.of(context).unfocus();
                          state.value?.remove(item);
                          state.didChange(state.value);
                        },
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
                        addIngredient: () {
                          FocusScope.of(context).unfocus();
                          final index = state.value!.indexOf(item);
                          (state.value![index] as IngredientSectionEntity)
                              .ingredients!
                              .add(
                                IngredientEntity(),
                              );
                          state.didChange(state.value);
                        },
                      );
                    }
                    return const SizedBox();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    state.value?.add(
                      IngredientEntity(),
                    );
                    state.didChange(state.value);
                    pageListScrollController.animateTo(
                      pageListScrollController.offset + 60,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'Ingrediente',
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    state.value?.add(
                      IngredientSectionEntity(
                        ingredients: [
                          IngredientEntity(),
                          IngredientEntity(),
                        ],
                      ),
                    );
                    state.didChange(state.value);
                    pageListScrollController.animateTo(
                      pageListScrollController.offset + 140,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'Seção',
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
