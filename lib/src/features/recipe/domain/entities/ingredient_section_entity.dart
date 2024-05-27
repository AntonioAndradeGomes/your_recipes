import 'package:equatable/equatable.dart';
import 'package:your_recipes/src/features/recipe/domain/entities/ingredient_entity.dart';

class IngredientSectionEntity extends Equatable {
  final int pos;
  final String name;
  final List<IngredientEntity> ingredients;

  const IngredientSectionEntity({
    required this.pos,
    required this.name,
    required this.ingredients,
  });

  @override
  List<Object?> get props => [
        pos,
        name,
        ingredients,
      ];
}
