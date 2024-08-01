import 'package:hive/hive.dart';

part 'images_blogs_db.g.dart'; // Add this line

@HiveType(typeId: 5)
class ImageBlog extends HiveObject {
  @HiveField(0)
  late String tripId; // Define tripId field

  @HiveField(1)
  late List<String> images;

  @HiveField(2)
  late List<String> blogs;
  ImageBlog({
    required this.tripId,
    required this.images,
    required this.blogs,
  });
}
