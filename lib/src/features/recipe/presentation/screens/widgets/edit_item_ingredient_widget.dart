import 'package:flutter/material.dart';
import 'package:your_recipes/src/common/entities/ingredient_entity.dart';

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
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: ingredientEntity.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Inválido';
              }
              return null;
            },
            onChanged: (value) => ingredientEntity.name = value,
            decoration: const InputDecoration(
              labelText: 'Quantidade',
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 2,
              ),
            ),
          ),
        ),
        Expanded(
          child: TextFormField(
            initialValue: ingredientEntity.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Inválido';
              }
              return null;
            },
            onChanged: (value) => ingredientEntity.name = value,
            decoration: const InputDecoration(
              labelText: 'Unidade',
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 2,
              ),
            ),
          ),
        ),
        Expanded(
          child: TextFormField(
            initialValue: ingredientEntity.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Inválido';
              }
              return null;
            },
            onChanged: (value) => ingredientEntity.name = value,
            decoration: const InputDecoration(
              labelText: 'Nome',
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 2,
              ),
            ),
          ),
        )
      ],
    );
  }
}
