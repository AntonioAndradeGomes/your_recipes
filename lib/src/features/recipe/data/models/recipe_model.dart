import 'package:your_recipes/src/common/entities/recipe_entity.dart';
import 'package:your_recipes/src/features/recipe/data/models/ingredient_model.dart';
import 'package:your_recipes/src/features/recipe/data/models/ingredient_section_model.dart';
import 'package:your_recipes/src/features/recipe/data/models/step_recipe_model.dart';

// ignore: must_be_immutable
class RecipeModel extends RecipeEntity {
  RecipeModel({
    String? id,
    String? userId,
    required String name,
    String? description,
    List<String>? images,
    List<dynamic>? newImages,
    required List<dynamic> baseIngredients,
    required List<StepRecipeModel> baseSteps,
    required String portions,
    required String preparationTime,
  }) : super(
          id: id,
          userId: userId,
          name: name,
          description: description,
          images: images,
          newImages: newImages,
          baseIngredients: baseIngredients,
          baseSteps: baseSteps,
          portions: portions,
          preparationTime: preparationTime,
        );

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json['id'],
        userId: json['userId'],
        name: json['name'] ?? '',
        description: json['description'],
        images: List.from(json['images'] ?? []),
        newImages: const [],
        baseIngredients: json['baseIngredients'] == null
            ? []
            : (json['baseIngredients'] as List<Map<String, dynamic>>).map(
                (e) {
                  if (e['type'] == 0) {
                    return IngredientModel.fromJson(e);
                  }
                  return IngredientSectionModel.fromJson(e);
                },
              ).toList(),
        baseSteps: json['baseSteps'] == null
            ? []
            : (json['baseSteps'] as List<Map<String, dynamic>>)
                .map((e) => StepRecipeModel.fromJson(e))
                .toList(),
        portions: json['portions'] ?? '',
        preparationTime: json['preparationTime'] ?? '',
      );

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'description': description,
      'baseIngredients': baseIngredients == null
          ? []
          : baseIngredients!.map(
              (e) {
                if (e is IngredientModel) {
                  return e.toMap();
                }
                if (e is IngredientSectionModel) {
                  return e.toMap();
                }
                return [];
              },
            ).toList(),
      'baseSteps': baseSteps == null
          ? []
          : baseSteps!.map((e) => (e as StepRecipeModel).toMap()).toList(),
      'portions': portions,
      'preparationTime': preparationTime,
    };
  }
}
