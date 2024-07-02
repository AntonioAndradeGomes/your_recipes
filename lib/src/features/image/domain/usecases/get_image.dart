import 'dart:io';
import 'package:your_recipes/src/features/image/domain/entities/image_source_type.dart';
import 'package:your_recipes/src/features/image/domain/repository/images_repository.dart';

class GetImage {
  final ImagesRepository _imagesRepository;

  GetImage(this._imagesRepository);

  Future<File?> call(ImageSourceType imageSource) {
    return _imagesRepository.pickImage(imageSource);
  }
}
