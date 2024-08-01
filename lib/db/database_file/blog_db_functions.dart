import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:trip_plannerx/model/images_blogs_db.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'dart:html' as html;

class BlogDbService {
  static const String blogBoxName = 'tripBlogs';
  static late Box<ImageBlog>? blogBox;

  static Future<void> init() async {
    if (!kIsWeb) {
      final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
      Hive.init(appDocumentDirectory.path);
    } else {
      Hive.init(html.window.localStorage['path'] ?? '');
    }
    blogBox = await Hive.openBox<ImageBlog>(blogBoxName);
  }

  static List<String> getBlogs(String tripId) {
    if (blogBox != null && blogBox!.isNotEmpty) {
      final imageBlog = blogBox!.values.firstWhere(
        (element) => element.tripId == tripId,
        orElse: () => ImageBlog(tripId: tripId, images: [], blogs: []),
      );
      return imageBlog.blogs;
    }
    return [];
  }

  static List<String> getAllBlogsFromAllTrips() {
    final List<String> allBlogs = [];
    if (blogBox != null && blogBox!.isNotEmpty) {
      for (final imageBlog in blogBox!.values) {
        allBlogs.addAll(imageBlog.blogs);
      }
    }
    return allBlogs;
  }

  static Future<void> addBlog(String newBlog, String tripId) async {
    final imageBlog = blogBox!.values.firstWhere(
      (element) => element.tripId == tripId,
      orElse: () => ImageBlog(tripId: tripId, images: [], blogs: []),
    );
    imageBlog.blogs.add(newBlog);
    await blogBox!.put(tripId, imageBlog);
  }

  static Future<void> editBlog(int index, String editedBlog, String tripId) async {
    final imageBlog = blogBox!.get(tripId);
    if (imageBlog != null) {
      imageBlog.blogs[index] = editedBlog;
      await blogBox!.put(tripId, imageBlog);
    }
  }

  static Future<void> deleteBlog(int index, String tripId) async {
    final imageBlog = blogBox!.get(tripId);
    if (imageBlog != null) {
      imageBlog.blogs.removeAt(index);
      await blogBox!.put(tripId, imageBlog);
    }
  }

  static Future<void> deleteBlogForAllBlogs(int index) async {
    if (blogBox != null && blogBox!.isNotEmpty) {
      for (final imageBlog in blogBox!.values) {
        if (imageBlog.blogs.length > index) {
          imageBlog.blogs.removeAt(index);
          await blogBox!.put(imageBlog.tripId, imageBlog);
        }
      }
    }
  }
}
