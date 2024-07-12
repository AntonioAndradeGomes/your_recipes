import 'package:equatable/equatable.dart';
import 'package:your_recipes/src/common/entities/ingredient_entity.dart';

// ignore: must_be_immutable
class IngredientSectionEntity extends Equatable {
  String? name;
  List<IngredientEntity>? ingredients;

  IngredientSectionEntity({
    this.name,
    this.ingredients,
  });

  @override
  List<Object?> get props => [
        name,
        ingredients,
      ];
}
