import 'package:hive_flutter/adapters.dart';

import 'package:trip_plannerx/model/model.dart';

class DatabaseHelper{
  static Future<void>addUSer(Login login) async{
    final box=await Hive.openBox<Login>('Login');
    await box.add(login);
  }

   static Future<bool> isLoggedIn(String username, String password) async {
    final loginDB = await Hive.openBox<Login>('Login');
    final result = loginDB.values.any(
        (login) => login.username == username && login.password == password);
    return result;
  }
  
  
}