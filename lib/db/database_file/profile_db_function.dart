

import 'package:hive/hive.dart';
import 'package:trip_plannerx/model/profile_db.dart';

class ProfileService {
  final Box<Profile> profileBox = Hive.box<Profile>('addprofile');

  void saveProfile(String userName, String? imagePath) {
    Profile profile = Profile(userName: userName, profilePicturepath: imagePath);
    profileBox.put('userProfile', profile);  // Save with  key
  }

  Profile? getProfile() {
    return profileBox.get('userProfile');  // Retrieve by key
  }
}