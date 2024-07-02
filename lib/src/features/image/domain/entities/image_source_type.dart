import 'package:flutter/material.dart';

enum ImageSourceType {
  gallery(
    label: 'Galeria',
    iconData: Icons.image_search_rounded,
  ),
  camera(
    label: 'Câmera',
    iconData: Icons.camera_alt_rounded,
  );

  final String label;
  final IconData iconData;

  const ImageSourceType({
    required this.label,
    required this.iconData,
  });
}
