import 'dart:io';

import 'package:your_recipes/src/features/image/data/datasource/images_datasource.dart';
import 'package:your_recipes/src/features/image/domain/entities/image_source_type.dart';
import 'package:your_recipes/src/features/image/domain/repository/images_repository.dart';

class ImagesRepositoryImp extends ImagesRepository {
  final ImagesDatasource _datasource;

  ImagesRepositoryImp(
    this._datasource,
  );
  @override
  Future<File?> pickImage(ImageSourceType imageSource) {
    return _datasource.pickImage(imageSource);
  }
}
