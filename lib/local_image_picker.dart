import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:imagepickerdemo/bl_image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class LocalImagePicker implements BlImagePicker {
  @override
  Future<File?> pickImage() async {
    XFile? pickedImage;
    try {
      pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    } on RangeError {
      return null;
    }
    final imageTemporary = File(pickedImage!.path);
    return imageTemporary;
  }

  @override
  Future<File> saveImage(File image, {String? newImageName}) async {
    final directory = await getApplicationDocumentsDirectory();
    var finalImageName = newImageName ?? DateTime.now().toString();
    final imagePath = join(directory.path, finalImageName);
    return image.copy(imagePath);
  }

  @override
  Future<File?> retrieveImage(String imageName) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = join(directory.path, imageName);
    final fileImage = File(imagePath);
    return fileImage;
  }
}
