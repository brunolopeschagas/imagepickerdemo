import 'dart:io';
import 'package:flutter/material.dart';
import 'package:imagepickerdemo/local_image_picker.dart';

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
  LocalImagePicker localImagePicker = LocalImagePicker();
  final TextEditingController _imageNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      localImagePicker.pickImage().then((value) {
                        printImage(value);
                      });
                    },
                    child: const Text('Pick a Image from the Gallery'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        saveImage(_storedImage, _imageNameController.text).then(
                      (value) {
                        print(_storedImage!.absolute.toString());
                      },
                    ),
                    child: const Text('Save image'),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    controller: _imageNameController,
                    decoration: const InputDecoration(
                      hintText: 'Image name to pick',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      localImagePicker
                          .retrieveImage(_imageNameController.text)
                          .then((value) {
                        printImage(value);
                      });
                    },
                    child: const Text('Retrieve Image from name'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void printImage(File? imagem) {
    setState(() {
      _storedImage = imagem;
    });
  }

  Future<File> saveImage(File? storedImage, String newImageName) {
    return localImagePicker.saveImage(storedImage!, newImageName: newImageName);
  }
}
