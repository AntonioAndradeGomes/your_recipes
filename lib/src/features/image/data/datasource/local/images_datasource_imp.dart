import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:your_recipes/src/features/image/data/datasource/images_datasource.dart';
import 'package:your_recipes/src/features/image/domain/entities/image_source_type.dart';

class ImagesDatasourceImp implements ImagesDatasource {
  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  ImagesDatasourceImp(
    this._imagePicker,
    this._imageCropper,
  );

  @override
  Future<File?> pickImage(ImageSourceType imageSource) async {
    try {
      final XFile? file = await _imagePicker.pickImage(
        source: imageSource == ImageSourceType.camera
            ? ImageSource.camera
            : ImageSource.gallery,
      );
      if (file == null) {
        return null;
      }

      final croppedFile = await _imageCropper.cropImage(
        sourcePath: file.path,
        aspectRatio: const CropAspectRatio(
          ratioX: 1.0,
          ratioY: 1.0,
        ),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Editar Imagem',
            toolbarWidgetColor: Colors.white,
          ),
          IOSUiSettings(
            title: 'Editar Imagem',
            cancelButtonTitle: 'Cancelar',
            doneButtonTitle: 'Concluir',
          ),
        ],
      );
      if (croppedFile == null) {
        return null;
      }

      return File(croppedFile.path);
    } catch (e) {
      return null;
    }
  }
}
