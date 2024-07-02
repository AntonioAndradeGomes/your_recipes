import 'dart:io';

import 'package:your_recipes/src/features/image/domain/entities/image_source_type.dart';

abstract class ImagesRepository {
  Future<File?> pickImage(ImageSourceType imageSource);
}
