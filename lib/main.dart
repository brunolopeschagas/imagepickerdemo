import 'dart:io';
import 'package:flutter/material.dart';
import 'package:imagepickerdemo/bl_image_picker.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Image Picker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImagePickerScreen(),
    );
  }
}

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _storedImage;
  BlImagePicker blImagePicker = BlImagePicker();
  TextEditingController _imageNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_storedImage != null)
              Image.file(
                _storedImage!,
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              )
            else
              const Text('No image selected.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                blImagePicker.pickImage().then((value) {
                  printImage(value);
                });
              },
              child: const Text('Pick Image from Gallery'),
            ),
            TextFormField(
              controller: _imageNameController,
              decoration: const InputDecoration(
                hintText: 'Image name to pick',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                blImagePicker
                    .retrieveImage(_imageNameController.text)
                    .then((value) {
                  printImage(value);
                });
              },
              child: const Text('Retrieve Image'),
            ),
            ElevatedButton(
              onPressed: () => saveImage(_storedImage).then(
                (value) {
                  print(_storedImage!.absolute.toString());
                },
              ),
              child: const Text('Save image'),
            ),
          ],
        ),
      ),
    );
  }

  void printImage(File? imagem) {
    setState(() {
      _storedImage = imagem;
    });
  }

  Future<File> saveImage(File? storedImage) {
    return blImagePicker.saveImageToLocalFileSystem(storedImage!);
  }
}
