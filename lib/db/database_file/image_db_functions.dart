import 'package:hive/hive.dart';
import 'package:trip_plannerx/model/images_blogs_db.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'dart:html' as html;
import 'package:flutter/foundation.dart' show kIsWeb;

class ImageDbService {
  static const String imageBoxName = 'tripImages';
  static late Box<ImageBlog>? imageBlogBox;

  static Future<void> init() async {
    if (!kIsWeb) {
      final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
      Hive.init(appDocumentDirectory.path);
    } else {
      Hive.init(html.window.localStorage['path'] ?? '');
    }
    imageBlogBox = await Hive.openBox<ImageBlog>(imageBoxName);
  }

  static List<String> getImages(String tripId) {
    if (imageBlogBox != null && imageBlogBox!.isNotEmpty) {
      final imageBlog = imageBlogBox!.values.firstWhere(
        (element) => element.tripId == tripId,
        orElse: () => ImageBlog(tripId: tripId, images: [], blogs: []),
      );
      return imageBlog.images;
    }
    return [];
  }

  static List<String> getAllImagesFromAllTrips() {
    final List<String> allImages = [];
    if (imageBlogBox != null && imageBlogBox!.isNotEmpty) {
      for (final imageBlog in imageBlogBox!.values) {
        allImages.addAll(imageBlog.images);
      }
    }
    return allImages;
  }

  static Future<void> addImages(List<String> newImages, String tripId) async {
    final imageBlog = imageBlogBox!.values.firstWhere(
      (element) => element.tripId == tripId,
      orElse: () => ImageBlog(tripId: tripId, images: [], blogs: []),
    );
    imageBlog.images.addAll(newImages);
    await imageBlogBox!.put(tripId, imageBlog);
  }

  static Future<void> deleteImage(int index, String tripId) async {
    final imageBlog = imageBlogBox!.get(tripId);
    if (imageBlog != null) {
      imageBlog.images.removeAt(index);
      await imageBlogBox!.put(tripId, imageBlog);
    }
  }
}
