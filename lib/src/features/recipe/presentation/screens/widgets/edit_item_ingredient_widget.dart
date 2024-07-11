import 'package:flutter/material.dart';
import 'package:your_recipes/src/common/entities/ingredient_entity.dart';
import 'package:your_recipes/src/common/utils/extensions.dart';
import 'package:your_recipes/src/common/widgets/custom_icon_button.dart';

class EditItemIngredientWidget extends StatelessWidget {
  final IngredientEntity ingredientEntity;
  final VoidCallback? onRemove;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;

  const EditItemIngredientWidget({
    super.key,
    required this.ingredientEntity,
    this.onRemove,
    this.onMoveUp,
    this.onMoveDown,
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
          Expanded(
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              initialValue: ingredientEntity.name,
              maxLines: null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Inválido';
                }
                return null;
              },
              onChanged: (value) => ingredientEntity.name = value,
              decoration: InputDecoration(
                hintText: ingredientEntity.labelExemple,
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
