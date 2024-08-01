import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class FullScreenImagePage extends StatelessWidget {
  final String imagePath;

  const FullScreenImagePage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: kIsWeb
            ? _buildWebImage(imagePath)
            : _buildMobileImage(imagePath),
      ),
    );
  }

  Widget _buildWebImage(String imagePath) {
    return Image.network(
      imagePath,
      fit: BoxFit.contain,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Text('Error loading image'));
      },
    );
  }

  Widget _buildMobileImage(String imagePath) {
    try {
      File imageFile = File(imagePath);
      if (!imageFile.existsSync()) {
        return const Center(child: Text('Image not found'));
      }
      return Image.file(
        imageFile,
        fit: BoxFit.contain,
        width: double.infinity,
        height: double.infinity,
      );
    } catch (e) {
      return Center(child: Text('Error loading image: $e'));
    }
  }
}
