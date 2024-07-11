import 'dart:math';

abstract class StepHelper {
  static List<String> stepExamples = [
    "Pré-aqueça o forno a 180°C.",
    "Unte a forma com manteiga e polvilhe farinha.",
    "Misture os ingredientes secos em uma tigela.",
    "Bata os ovos com o açúcar até obter um creme claro.",
    "Adicione o óleo e o leite à mistura de ovos e açúcar.",
    "Incorpore os ingredientes secos à mistura líquida, mexendo até homogeneizar.",
    "Despeje a massa na forma preparada.",
    "Asse por 30-35 minutos ou até dourar.",
    "Deixe esfriar antes de desenformar.",
    "Sirva com uma cobertura de sua escolha.",
    "Refogue a cebola e o alho no azeite até dourarem.",
    "Adicione o frango e cozinhe até ficar dourado.",
    "Despeje o molho de tomate e deixe cozinhar por 20 minutos.",
    "Tempere com sal, pimenta e ervas a gosto.",
    "Cozinhe a massa conforme as instruções da embalagem.",
    "Misture a massa cozida com o molho.",
    "Salpique queijo ralado antes de servir.",
    "Deixe a massa descansar por 10 minutos antes de cortar.",
    "Corte os legumes em pedaços pequenos.",
    "Cozinhe os legumes no vapor por 5 minutos.",
    "Prepare o arroz conforme as instruções da embalagem.",
    "Misture os legumes cozidos com o arroz.",
    "Tempere com sal, pimenta e azeite a gosto.",
    "Sirva imediatamente.",
    "Prepare o caldo de galinha conforme as instruções.",
    "Corte a carne em cubos pequenos.",
    "Marine a carne com sal, pimenta e ervas por 30 minutos.",
    "Grelhe a carne até atingir o ponto desejado.",
    "Cozinhe as batatas até ficarem macias.",
    "Amasse as batatas com manteiga e leite até obter um purê.",
    "Sirva o purê com a carne grelhada.",
    "Pique o chocolate em pedaços pequenos.",
    "Derreta o chocolate em banho-maria.",
    "Misture o chocolate derretido com creme de leite.",
    "Despeje a mistura em uma forma e leve à geladeira.",
    "Deixe gelar por 2 horas antes de servir.",
  ];

  static String getRandomStep() {
    final random = Random();
    return stepExamples[random.nextInt(stepExamples.length)];
  }
}
