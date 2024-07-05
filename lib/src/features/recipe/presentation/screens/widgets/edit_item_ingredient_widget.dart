import 'package:flutter/material.dart';
import 'package:your_recipes/src/common/entities/ingredient_entity.dart';
import 'package:your_recipes/src/common/utils/extensions.dart';
import 'package:your_recipes/src/common/widgets/custom_icon_button.dart';

class EditItemIngredientWidget extends StatelessWidget {
  final IngredientEntity ingredientEntity;
  final VoidCallback? onRemove;
  const EditItemIngredientWidget({
    super.key,
    required this.ingredientEntity,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: ingredientEntity.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Inválido';
              }
              return null;
            },
            onChanged: (value) => ingredientEntity.name = value,
            decoration: const InputDecoration(
              hintText: '200g de muçarela',
              isDense: true,
            ),
          ),
        ),
        CustomIconButton(
          onTap: onRemove,
          icon: Icons.delete,
          color: colors.primary,
        ),
        CustomIconButton(
          icon: Icons.menu,
          color: colors.primary,
        ),
      ],
    );
  }
}
