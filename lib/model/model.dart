

import 'package:hive_flutter/adapters.dart';
  part 'model.g.dart';
@HiveType(typeId: 1)
class Login  {
  @HiveField(0)
   String username;
  @HiveField(1)
  String password;
 @HiveField(2)
 final String email;
  Login({required this.username,required this.password, this.email=''});
}