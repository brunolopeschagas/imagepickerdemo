import 'dart:io';

abstract class BlImagePicker {
  Future<File?> pickImage();
  Future<File> saveImage(File image, {String? newImageName});
  Future<File?> retrieveImage(String imageName);
}
