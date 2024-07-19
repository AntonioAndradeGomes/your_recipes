import 'package:your_recipes/src/features/recipe/domain/entities/ingredient_section_entity.dart';
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

  factory IngredientSectionModel.fromEntity(IngredientSectionEntity entity) =>
      IngredientSectionModel(
        name: entity.name ?? '',
        ingredients: entity.ingredients == null
            ? []
            : entity.ingredients!
                .map(
                  (e) => IngredientModel(
                    name: e.name ?? '',
                  ),
                )
                .toList(),
      );
}
