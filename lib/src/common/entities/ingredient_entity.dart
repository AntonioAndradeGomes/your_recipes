import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class IngredientEntity extends Equatable {
  String? measurementUnit;
  String? quantity;
  String? name;

  IngredientEntity({
    this.measurementUnit,
    this.quantity,
    this.name,
  });

  @override
  List<Object?> get props => [
        measurementUnit,
        quantity,
        name,
      ];
}
