import 'package:equatable/equatable.dart';

class IngredientEntity extends Equatable {
  final String measurementUnit;
  final String quantity;
  final String name;

  const IngredientEntity({
    required this.measurementUnit,
    required this.quantity,
    required this.name,
  });

  @override
  List<Object?> get props => [
        measurementUnit,
        quantity,
        name,
      ];
}
