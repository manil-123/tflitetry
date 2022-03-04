import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  List? _results;
  String _confidence = "";
  String _name = "";
  String number = "";

  Future<File?> _getFromGallery() async {
    _image = null;
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
    _image != null ? applyModelOnImage(_image!) : null;
    return _image != null ? _image! : null;
  }

  Future<File?> _getFromCamera() async {
    _image = null;
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
    _image != null ? applyModelOnImage(_image!) : null;
    return _image != null ? _image! : null;
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  loadModel() async {
    var resultant = await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
    print('result after loading model : $resultant');
  }

  applyModelOnImage(File file) async {
    var res = await Tflite.runModelOnImage(
      path: file.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _results = res;
      print(_results.toString());
      String str = _results![0]['label'];
      _name = str.substring(1);
      _confidence = _results != null
          ? (_results![0]['confidence'] * 100.0).toString().substring(0, 2) +
              "%"
          : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tflite'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () async {
                    await _getFromGallery();

                    setState(() {});
                  },
                  child: _image == null
                      ? const Icon(
                          Icons.add_a_photo,
                          size: 30,
                        )
                      : Image.file(
                          _image!,
                          height: 400,
                          width: 400,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
            ),
            Text('Name: $_name'),
            Text('Confidence: $_confidence'),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                await _getFromCamera();
              },
              child: Text('Open Camera'),
            )
          ],
        ),
      ),
    );
  }
}
