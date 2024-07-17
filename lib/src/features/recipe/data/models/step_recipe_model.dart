import 'package:your_recipes/src/common/entities/step_recipe_entity.dart';

// ignore: must_be_immutable
class StepRecipeModel extends StepRecipeEntity {
  StepRecipeModel({
    required String description,
  }) : super(
          description: description,
        );

  factory StepRecipeModel.fromJson(Map<String, dynamic> json) =>
      StepRecipeModel(
        description: json['description'] ?? '',
      );

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'type': 0,
    };
  }
}
