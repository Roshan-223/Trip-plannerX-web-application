import 'package:flutter/material.dart';
import 'package:trip_plannerx/screens/home/bottom_navigation_screens/bottom.profile.dart';
import 'package:trip_plannerx/screens/home/bottom_navigation_screens/bottom_fav.dart';
import 'package:trip_plannerx/screens/home/bottom_navigation_screens/bottom_schedule.dart';
import 'package:trip_plannerx/screens/home/bottom_navigation_screens/bottom_search.dart';
import 'package:trip_plannerx/screens/home/homepage.dart';

class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int selectedIndex = 0;

  List<IconData> icons = [
    Icons.home,
    Icons.search,
    Icons.calendar_month_outlined,
    Icons.favorite_border,
    Icons.person_2_outlined
  ];

  List<String> labels = [
    'Home',
    'Search',
    'Schedule',
    'Favorites',
    'Profile',
  ];

  List<Widget> screens = [
    const HomeScreen(descriptions: [],titles: [],imageUrls: []),
    const BottomSearch(),
    const ScheduleListPage(),
    const FavoritePlacesPage(),
     const BottomProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: icons
            .map((icon) => BottomNavigationBarItem(
                  icon: Icon(icon),
                  label: '',
                ))
            .toList(),
      ),
      body: screens[selectedIndex],
    );
  }
}
