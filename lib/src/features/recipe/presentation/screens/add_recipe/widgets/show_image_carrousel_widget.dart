import 'dart:io';
import 'package:flutter/material.dart';

class ShowImageCarrouselWidget extends StatelessWidget {
  final dynamic image;
  final VoidCallback? onPressed;
  const ShowImageCarrouselWidget({
    super.key,
    this.image,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (image is String)
          Image.network(
            image,
            fit: BoxFit.cover,
          )
        else
          Image.file(
            image as File,
            fit: BoxFit.cover,
          ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: onPressed,
            color: Colors.red,
            icon: const Icon(
              Icons.remove_circle,
            ),
          ),
        ),
      ],
    );
  }
}
