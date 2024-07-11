import 'package:your_recipes/src/common/helpers/steps_helper.dart';

class StepRecipeEntity {
  String? description;
  String? descriptionExemple;

  StepRecipeEntity({
    this.description,
  }) {
    descriptionExemple = StepHelper.getRandomStep();
  }
}
