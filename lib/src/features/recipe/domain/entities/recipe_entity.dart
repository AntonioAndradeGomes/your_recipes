import 'package:equatable/equatable.dart';
import 'package:your_recipes/src/features/recipe/domain/entities/ingredient_entity.dart';

class RecipeEntity extends Equatable {
  final String? id;
  final String name;
  final String? description;
  final List<IngredientEntity>? baseIngredients;

  const RecipeEntity({
    this.id,
    required this.name,
    this.description,
    this.baseIngredients,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        baseIngredients,
      ];
}
