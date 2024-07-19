import 'package:equatable/equatable.dart';
import 'package:your_recipes/src/common/helpers/ingredient_helper.dart';

// ignore: must_be_immutable
class IngredientEntity extends Equatable {
  String? name;
  String? labelExemple;

  IngredientEntity({
    this.name,
  }) {
    labelExemple = IngredientHelper.getRandomIngredient();
  }

  @override
  List<Object?> get props => [name, labelExemple];
}
