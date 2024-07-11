import 'package:your_recipes/src/common/helpers/ingredient_helper.dart';

class IngredientEntity {
  String? name;
  String? labelExemple;

  IngredientEntity({
    this.name,
  }) {
    labelExemple = IngredientHelper.getRandomIngredient();
  }
}
