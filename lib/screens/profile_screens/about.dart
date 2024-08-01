import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Trip PlannerX'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView( 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Text(
                "Trip PlannerX is your travel buddy, helping you plan unforgettable trips across India. Whether you are a solo traveler or planning a trip with friends or family, Trip PlannerX has you covered with a range of useful features to make your travel experience smooth and enjoyable.",
                style: TextStyle(fontSize: 16), 
              ),
              SizedBox(height: 16), 
              Text(
                "With Trip PlannerX, you can explore and search for different tourist destinations across India. From the bustling streets of Delhi to the serene backwaters of Kerala, the app lets you find unique and exciting places to visit. Need directions to your next spot? No problem—Trip PlannerX integrates with Google Maps, giving you turn-by-turn directions to ensure you never get lost on your journey.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "One of the best features of Trip PlannerX is the ability to create a personalized wishlist of destinations. If you find a place you really want to visit, just add it to your wishlist. This way, you can keep track of all your dream locations and make sure you never miss out on a great trip.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "Planning a trip with friends? Trip PlannerX makes it easy to organize everything in one place. You can select companions, choose your destination, and set the dates for your trip. You can even add the trip's end dates to your itinerary, helping you stay on track with your plans.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "Need to split expenses? Trip PlannerX has you covered! You can divide the total expense among your companions without using any other apps. Just enter the total amount, and the app will do the math for you.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "Dreaming of a big trip in the future? You can even add your dream destination and track your savings in the app. This way, you can keep an eye on your progress and stay motivated to reach your travel goals.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "Once your trip is over, Trip PlannerX helps you keep the memories alive. You can add your photos and write blogs about your experiences in the app. This way, you can relive the best moments and share them with friends and family.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "So whether you're planning a quick weekend getaway or an epic adventure, Trip PlannerX is here to make sure everything goes smoothly. Pack your bags, grab your companions, and get ready for an amazing journey with Trip PlannerX—your ultimate trip planning companion.",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
