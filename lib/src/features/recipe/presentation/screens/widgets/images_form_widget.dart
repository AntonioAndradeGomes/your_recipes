import 'dart:io';

import 'package:flutter/material.dart';
import 'package:your_recipes/providers.dart';
import 'package:your_recipes/src/common/dialogs/image_source_dialog.dart';
import 'package:your_recipes/src/features/image/domain/entities/image_source_type.dart';
import 'package:your_recipes/src/common/widgets/food_carrousel_slider_widget.dart';
import 'package:your_recipes/src/features/image/domain/usecases/get_image.dart';
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
        void onImageAdd(File? file) {
          if (file != null) {
            state.value?.add(file);
            state.didChange(state.value);
          }
        }

        void onRemoveImage(dynamic image) {
          state.value?.remove(image);
          state.didChange(state.value);
        }

        return Column(
          children: [
            FoodCarrouselSliderWidget(
              items: state.value!.map<Widget>(
                (image) {
                  return ShowImageCarrouselWidget(
                    image: image,
                    onPressed: () {
                      onRemoveImage(image);
                    },
                  );
                },
              ).toList()
                ..add(
                  Material(
                    color: Colors.grey[100],
                    child: IconButton(
                      onPressed: () async {
                        final source = await showDialog<ImageSourceType?>(
                          context: context,
                          builder: (_) => const ImageSourceDialog(),
                        );
                        if (source != null) {
                          final image = await getIt<GetImage>().call(source);
                          onImageAdd(image);
                        }
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
