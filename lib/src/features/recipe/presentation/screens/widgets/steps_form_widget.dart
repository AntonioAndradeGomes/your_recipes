import 'package:flutter/material.dart';
import 'package:your_recipes/src/common/entities/step_recipe_entity.dart';
import 'package:your_recipes/src/common/utils/extensions.dart';
import 'package:your_recipes/src/common/widgets/custom_icon_button.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/widgets/edit_item_step_widget.dart';

class StepsFormWidget extends StatelessWidget {
  final List<StepRecipeEntity>? listSteps;
  const StepsFormWidget({
    super.key,
    this.listSteps,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return FormField<List<StepRecipeEntity>>(
      initialValue: listSteps ??
          [
            StepRecipeEntity(),
            StepRecipeEntity(),
          ],
      validator: (items) {
        if (items == null || items.isEmpty) {
          return 'A receita deve ter ao menos 1 passo';
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
                    'Passo a passo',
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
                      StepRecipeEntity(),
                    );
                    state.didChange(state.value);
                  },
                ),
              ],
            ),
            if (state.value != null)
              Column(
                children: state.value!.map<Widget>(
                  (step) {
                    return EditItemStepWidget(
                      key: ObjectKey(step),
                      stepEntity: step,
                      onRemove: () {
                        state.value?.remove(step);
                        state.didChange(state.value);
                      },
                      onMoveUp: step != state.value!.first
                          ? () {
                              final index = state.value!.indexOf(step);
                              state.value?.remove(step);
                              state.value?.insert(index - 1, step);
                              state.didChange(state.value);
                            }
                          : null,
                      onMoveDown: step != state.value!.last
                          ? () {
                              final index = state.value!.indexOf(step);
                              state.value?.remove(step);
                              state.value?.insert(index + 1, step);
                              state.didChange(state.value);
                            }
                          : null,
                    );
                  },
                ).toList(),
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
