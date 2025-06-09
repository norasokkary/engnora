import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tensorflow_lite/flutter_tensorflow_lite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:predicts_diabetes/JSON/users.dart';
// import 'package:predicts_diabetes/SQLite/database_helper.dart';
import 'package:predicts_diabetes/home_screen.dart';
import 'package:predicts_diabetes/results_page.dart';
// import 'package:tflite/tflite.dart';

class UploadPage extends StatefulWidget {
  final Users? user;
  const UploadPage({super.key, this.user});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  bool _isLoading = false;
  File? file;
  XFile? _selectedImage;
  List? _recognitions = [];
  double? confidence;
  String? label;
  // final db = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future detectImage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 5,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _recognitions = recognitions;
      confidence = _recognitions?[0]["confidence"] ?? 0;
      label = _recognitions?[0]["label"] ?? "";
      resultFilter();
    });
  }

  void resultFilter() {
    if (_recognitions != null) {
      for (var res in _recognitions!) {
        print("res[confidence] ${res["confidence"]}");
        print("res[label] ${res["label"]}");

        if (res["confidence"] > confidence) {
          confidence = res["confidence"];
          label = res["label"];
        }
      }
    }
    print("\n\n\n");
    print("Highest confidence $confidence");
    print("label $label");
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
        file = File(image.path);
      });
      detectImage(file!);
    }
  }

  Future<void> _analyzeImage() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulated analysis
      final analysisDate = DateTime.now().toString().substring(0, 16);
      final hasDiabetes = true; // Replace with actual analysis logic
      // final confidence = 0.87; // Replace with actual analysis logic

      if (widget.user != null) {
        // await db.createPhoto({
        //   'userId': widget.userId,
        //   'photoPath': _selectedImage!.path,
        //   'hasDiabetes': hasDiabetes ? 1 : 0,
        //   'confidence': confidence,
        //   'analysisDate': analysisDate,
        // });
      }

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(
            hasDiabetes: hasDiabetes,
            confidence: confidence ?? 0,
            analysisDate: label ?? "",
            selectedImage: _selectedImage,
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cornea Analysis'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: const Text(
                    'Upload a clear image of your cornea. Our system will analyze it to detect possible signs of diabetes and provide a detailed report.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Text(
                  'Upload Cornea Image for Analysis',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: _selectedImage == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_upload_outlined,
                                    size: 60, color: Colors.grey.shade600),
                                const SizedBox(height: 12),
                                Text(
                                  'Tap to upload image',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                OutlinedButton.icon(
                                  onPressed: _pickImage,
                                  icon: const Icon(Icons.folder_open),
                                  label: const Text('Choose from device'),
                                ),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(_selectedImage!.path),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _analyzeImage,
                  icon: const Icon(Icons.health_and_safety),
                  label: const Text('Start Analysis'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: SpinKitFadingCircle(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
