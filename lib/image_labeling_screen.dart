import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'image_picker_helper.dart'; // Import the helper file for image picking
import 'dart:ui' as ui;
import 'dart:io';

class ImageLabelingScreen extends StatefulWidget {
  const ImageLabelingScreen({super.key});

  @override
  _ImageLabelingScreenState createState() => _ImageLabelingScreenState();
}

class _ImageLabelingScreenState extends State<ImageLabelingScreen> {
  File? _imageFile;
  List<ImageLabel>? _labels;
  bool _isProcessing = false;

  // Function to pick an image
  Future<void> _getImage() async {
    final image = await pickImage(); // Call pickImage() from helper
    setState(() {
      _imageFile = image;
      _isProcessing = true;
    });

    // Process the image with ML Kit
    if (image != null) {
      await _labelImage(image);
    }
  }

  // Function to label the image using ML Kit
  Future<void> _labelImage(File image) async {
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();

    // Get labels from ML Kit
    final labels = await labeler.processImage(visionImage);

    setState(() {
      _labels = labels;
      _isProcessing = false;
    });
  }

  // Function to save annotated image
  Future<void> _saveAnnotatedImage() async {
    if (_imageFile == null || _labels == null || _labels!.isEmpty) return;

    // Load the image
    final imgBytes = await _imageFile!.readAsBytes();
    final image = await decodeImageFromList(imgBytes);

    // Create a PictureRecorder and Canvas to draw text on the image
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(
      recorder,
      Rect.fromPoints(const Offset(0, 0),
          Offset(image.width.toDouble(), image.height.toDouble())),
    );

    // Draw the image on the canvas
    canvas.drawImage(image, const Offset(0, 0), Paint());

    // Draw labels and confidence scores with rectangles
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    for (var label in _labels!) {
      final labelText =
          '${label.text} (${(label.confidence != null ? (label.confidence! * 100) : 0.0).toStringAsFixed(2)}%)';
      final textSpan = TextSpan(text: labelText, style: textStyle);
      final textPainter =
          TextPainter(text: textSpan, textDirection: TextDirection.ltr)
            ..layout(minWidth: 0, maxWidth: image.width.toDouble());

      // Calculate text position
      final offsetY = (10 + _labels!.indexOf(label) * 30).toDouble();

      // Paint the text on the canvas
      textPainter.paint(canvas, Offset(10.0, offsetY));

      // Draw a rectangle around the label text
      canvas.drawRect(
        Rect.fromLTWH(10.0, offsetY, textPainter.width, textPainter.height),
        paint,
      );
    }

    // Save the annotated image
    final picture = recorder.endRecording();
    final img = await picture.toImage(image.width, image.height);
    final annotatedImgBytes =
        await img.toByteData(format: ui.ImageByteFormat.png);
    final byteData = annotatedImgBytes!.buffer.asUint8List();

    // Save the image to the gallery
    final result =
        await ImageGallerySaver.saveImage(byteData, name: 'annotated_image');

    // Provide user feedback
    if (result['isSuccess']) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Image saved to gallery!')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to save image.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ML Kit Image Labeling'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile == null
                ? const Text('No image selected.')
                : Image.file(_imageFile!), // Display the selected image
            const SizedBox(height: 20),
            _isProcessing
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _getImage, // Trigger image picking
                    child: const Text('Pick an Image'),
                  ),
            const SizedBox(height: 20),
            _labels != null && _labels!.isNotEmpty
                ? Column(
                    children: _labels!.map((label) {
                      return ListTile(
                        title: Text('${label.text}'),
                        subtitle: Text(
                          'Confidence: ${(label.confidence != null ? (label.confidence! * 100) : 0.0).toStringAsFixed(2)}%',
                        ),
                      );
                    }).toList(),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveAnnotatedImage, // Save the annotated image
              child: const Text('Save Annotated Image'),
            ),
          ],
        ),
      ),
    );
  }
}
