enum UnitOfMeasure {
  //sem medida - a gosto
  toYourTaste('A gosto'),
  //sem medida - a gosto para decorar - to your taste (garnish)
  toYourTasteGarnish('A gosto (para decorar)'),
  // Medidas de Volume
  milliliters('Mililitros'),
  liters('Litros'),

  // Medidas de Peso
  grams('Gramas'),
  kilograms('Quilogramas'),

  // Medidas de Quantidade
  units('Unidades'),
  packs('Pacotes'),

  // Medidas Caseiras
  teaCups('Xícaras de chá'),
  tableSpoons('Colheres de sopa'),
  teaSpoons('Colheres de chá'),

  // Outras Medidas
  pinch('Pitada'),
  slice('Fatia'),
  clove('Dente'),
  bunch('Maço'),
  piece('Pedaço');

  final String displayName;

  const UnitOfMeasure(this.displayName);
}
