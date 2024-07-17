import 'package:your_recipes/src/common/entities/ingredient_section_entity.dart';

import 'ingredient_model.dart';

// ignore: must_be_immutable
class IngredientSectionModel extends IngredientSectionEntity {
  IngredientSectionModel({
    required String name,
    required List<IngredientModel> ingredients,
  }) : super(
          name: name,
          ingredients: ingredients,
        );

  factory IngredientSectionModel.fromJson(Map<String, dynamic> json) =>
      IngredientSectionModel(
        name: json['name'] ?? '',
        ingredients: (json['ingredients'] == null)
            ? []
            : (json['ingredients'] as List)
                .map(
                  (e) => IngredientModel.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ingredients': ingredients == null
          ? []
          : ingredients!
              .map(
                (e) => (e as IngredientModel).toMap(),
              )
              .toList(),
      'type': 1,
    };
  }
}
