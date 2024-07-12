import 'package:flutter/material.dart';
import 'package:your_recipes/src/common/entities/ingredient_section_entity.dart';
import 'package:your_recipes/src/common/utils/extensions.dart';
import 'package:your_recipes/src/common/widgets/custom_icon_button.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/widgets/edit_item_ingredient_widget.dart';

class SectionIngredientsFormWidget extends StatelessWidget {
  final IngredientSectionEntity ingredientSectionEntity;
  final ScrollController pageListScrollController;
  final VoidCallback? onRemove;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;
  final VoidCallback? addIngredient;
  const SectionIngredientsFormWidget({
    super.key,
    required this.ingredientSectionEntity,
    required this.pageListScrollController,
    this.onRemove,
    this.onMoveUp,
    this.onMoveDown,
    this.addIngredient,
  });

  @override
  Widget build(BuildContext context) {
    //final textTheme = context.textTheme;
    final colors = context.colorScheme;
    return FormField<IngredientSectionEntity>(
      initialValue: ingredientSectionEntity,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.ingredients == null) {
          return 'Adicione pelo menos 1 ingrediente a seção';
        }
        if (value.ingredients != null && value.ingredients!.isEmpty) {
          return 'Adicione pelo menos 1 ingrediente a seção';
        }
        return null;
      },
      builder: (state) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: ingredientSectionEntity.name,
                    maxLines: null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nome obrigatório';
                      }
                      return null;
                    },
                    onChanged: (value) => ingredientSectionEntity.name = value,
                    decoration: const InputDecoration(
                      hintText: 'Título da seção',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      isDense: true,
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomIconButton(
                  icon: Icons.arrow_drop_up_rounded,
                  color: colors.primary,
                  onTap: onMoveUp,
                ),
                CustomIconButton(
                  icon: Icons.arrow_drop_down_rounded,
                  color: colors.primary,
                  onTap: onMoveDown,
                ),
                CustomIconButton(
                  onTap: addIngredient,
                  icon: Icons.add,
                  color: colors.primary,
                ),
                CustomIconButton(
                  onTap: onRemove,
                  icon: Icons.delete,
                  color: Colors.red,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                children: state.value!.ingredients!.map<Widget>((item) {
                  return EditItemIngredientWidget(
                    key: ObjectKey(item),
                    ingredientEntity: item,
                    onRemove: () {
                      FocusScope.of(context).unfocus();
                      state.value!.ingredients?.remove(item);
                      state.didChange(state.value);
                    },
                    onMoveUp: item != state.value!.ingredients?.first
                        ? () {
                            final index =
                                state.value!.ingredients?.indexOf(item);
                            if (index != null) {
                              state.value!.ingredients?.remove(item);
                              state.value!.ingredients?.insert(index - 1, item);
                              state.didChange(state.value);
                            }
                          }
                        : null,
                    onMoveDown: item != state.value!.ingredients?.last
                        ? () {
                            final index =
                                state.value!.ingredients?.indexOf(item);
                            if (index != null) {
                              state.value!.ingredients?.remove(item);
                              state.value!.ingredients?.insert(index + 1, item);
                              state.didChange(state.value);
                            }
                          }
                        : null,
                  );
                }).toList(),
              ),
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
