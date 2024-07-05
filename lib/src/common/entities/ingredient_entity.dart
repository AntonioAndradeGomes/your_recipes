import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class IngredientEntity extends Equatable {
  int? pos;
  String? name;

  IngredientEntity({
    this.pos,
    this.name,
  });

  @override
  List<Object?> get props => [
        pos,
        name,
      ];
}
