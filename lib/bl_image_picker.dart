import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class BlImagePicker {
  Future<File?> pickImage() async {
    XFile? pickedImage;
    try {
      pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    } on RangeError {
      return null;
    }
    final imageTemporary = File(pickedImage!.path);
    // final savedImage = await _saveImageToLocalFileSystem(imageTemporary);
    return imageTemporary;
  }

  Future<File> saveImageToLocalFileSystem(File image,
      {String? newImageName}) async {
    final directory = await getApplicationDocumentsDirectory();
    var finalImageName = newImageName ?? DateTime.now().toString();
    final imagePath = join(directory.path, finalImageName);
    return image.copy(imagePath);
  }

  Future<File?> retrieveImage(String imageName) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = join(directory.path, imageName);
    final fileImage = File(imagePath);
    return fileImage;
  }
}
