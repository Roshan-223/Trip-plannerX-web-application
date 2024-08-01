import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trip_plannerx/model/dream_db.dart';
import 'package:trip_plannerx/model/favorite_db.dart';
import 'package:trip_plannerx/model/images_blogs_db.dart';
import 'package:trip_plannerx/model/profile_db.dart';
import 'package:trip_plannerx/model/schedule_db.dart';
import 'package:trip_plannerx/model/model.dart';
import 'package:trip_plannerx/screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await  Hive.initFlutter();
  Hive.registerAdapter(LoginAdapter());
  Hive.registerAdapter(ScheduleAdapter());
  Hive.registerAdapter(ProfileAdapter());
  Hive.registerAdapter(DreamAdapter());
  Hive.registerAdapter(ImageBlogAdapter());
  Hive.registerAdapter(FavoriteAdapter());
  await Hive.openBox<Schedule>('addtrip');
  await Hive.openBox<Profile>('addProfile');
  await Hive.openBox<Dream>('dream_destination');
  await Hive.openBox<ImageBlog>('imageblog');
  await Hive.openBox<Favorite>('place');
  await Hive.openBox<int>('tripIds'); 
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trip PlannerX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
