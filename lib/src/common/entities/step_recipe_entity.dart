import 'package:equatable/equatable.dart';
import 'package:your_recipes/src/common/helpers/steps_helper.dart';

// ignore: must_be_immutable
class StepRecipeEntity extends Equatable {
  String? description;
  String? descriptionExemple;

  StepRecipeEntity({
    this.description,
  }) {
    descriptionExemple = StepHelper.getRandomStep();
  }

  @override
  List<Object?> get props => [
        description,
        descriptionExemple,
      ];
}
