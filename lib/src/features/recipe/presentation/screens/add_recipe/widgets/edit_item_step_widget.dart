import 'package:flutter/material.dart';
import 'package:your_recipes/src/features/recipe/domain/entities/step_recipe_entity.dart';
import 'package:your_recipes/src/common/utils/extensions.dart';
import 'package:your_recipes/src/common/widgets/custom_icon_button.dart';

class EditItemStepWidget extends StatelessWidget {
  final StepRecipeEntity stepEntity;
  final VoidCallback? onRemove;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;
  final int pos;
  const EditItemStepWidget({
    super.key,
    required this.stepEntity,
    this.onRemove,
    this.onMoveUp,
    this.onMoveDown,
    required this.pos,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: colors.primary,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              pos.toString(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              initialValue: stepEntity.description,
              maxLines: null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Inválido';
                }
                return null;
              },
              onChanged: (value) => stepEntity.description = value,
              decoration: InputDecoration(
                hintText: stepEntity.descriptionExemple,
                isDense: true,
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
            onTap: onRemove,
            icon: Icons.delete,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
