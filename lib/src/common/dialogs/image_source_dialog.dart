import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:your_recipes/src/features/image/domain/entities/image_source_type.dart';

class ImageSourceDialog extends StatelessWidget {
  const ImageSourceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Escolha a origem da imagem',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ImageSourceType.values
              .map(
                (e) => InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    context.pop(e);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        e.iconData,
                        size: 35,
                        color: primaryColor,
                      ),
                      Text(
                        e.label,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: primaryColor,
                            ),
                      ),
                    ],
                  ),
                ),
              )
              .toList()),
    );
  }
}
