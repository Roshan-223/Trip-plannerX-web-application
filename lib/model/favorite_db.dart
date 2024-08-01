
import 'package:hive/hive.dart';
 part 'favorite_db.g.dart';
@HiveType(typeId: 9) 
class Favorite {
  @HiveField(0)
  final String place;

  Favorite(this.place, );
}