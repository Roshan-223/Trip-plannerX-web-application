import 'package:hive/hive.dart';
part 'profile_db.g.dart';

@HiveType(typeId: 3)
class Profile {
  @HiveField(0)
  String userName;
  @HiveField(1)
  String? profilePicturepath;
  Profile({required this.userName, required this.profilePicturepath});
}
