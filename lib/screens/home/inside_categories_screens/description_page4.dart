import 'package:flutter/material.dart';
import 'package:trip_plannerx/screens/home/inside_categories_screens/description_page0.dart';

class DecriptionPage4 extends StatelessWidget {
  const DecriptionPage4(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.description,
      required this.latitude,
      required this.longitude});
  final String title;
  final String imageUrl;
  final String description;
  final double latitude;
  final double longitude;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 20,
            ),
            Image(
              image: NetworkImage(imageUrl),
              width: 350,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(description),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () {
                launchMap(latitude, longitude);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 22.0),
                child: Text('Direction'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
