import 'package:your_recipes/src/common/entities/ingredient_entity.dart';

// ignore: must_be_immutable
class IngredientModel extends IngredientEntity {
  IngredientModel({
    required String name,
  }) : super(
          name: name,
        );

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      IngredientModel(
        name: json['name'] ?? '',
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': 0,
    };
  }
}
