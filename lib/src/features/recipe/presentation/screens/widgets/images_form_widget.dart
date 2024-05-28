import 'package:flutter/material.dart';
import 'package:your_recipes/src/common/widgets/food_carrousel_slider_widget.dart';
import 'package:your_recipes/src/features/recipe/domain/entities/recipe_entity.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/widgets/show_image_carrousel_widget.dart';

class ImagesFormWidget extends StatelessWidget {
  final RecipeEntity recipeEntity;
  const ImagesFormWidget({
    super.key,
    required this.recipeEntity,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: List.from(recipeEntity.imagens ?? []),
      validator: (imagens) {
        if (imagens == null || imagens.isEmpty) {
          return 'Insira ao menos uma imagem';
        }
        return null;
      },
      onSaved: (list) {},
      builder: (state) {
        return Column(
          children: [
            FoodCarrouselSliderWidget(
              items: state.value!.map<Widget>(
                (image) {
                  return ShowImageCarrouselWidget(
                    image: image,
                    onPressed: () {},
                  );
                },
              ).toList()
                ..add(
                  Material(
                    color: Colors.grey[100],
                    child: IconButton(
                      onPressed: () {
                        //todo: se não dor android ou ios  uma dialog
                        /* if (Platform.isAndroid) {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => ImageSourceSheeat(
                              onImageSelected: onImageSelected,
                            ),
                          );
                        } else {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (_) => ImageSourceSheeat(
                              onImageSelected: onImageSelected,
                            ),
                          );
                        }*/
                      },
                      iconSize: 100,
                      tooltip: 'Adicionar Foto',
                      color: Theme.of(context).primaryColor,
                      icon: const Icon(
                        Icons.add_a_photo_rounded,
                      ),
                    ),
                  ),
                ),
            ),
            if (state.hasError)
              Container(
                margin: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
