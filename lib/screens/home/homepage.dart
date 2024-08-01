import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:trip_plannerx/screens/home/add_trip.dart';
import 'package:trip_plannerx/screens/home/categories_screens/categories_page1.dart';
import 'package:trip_plannerx/screens/home/categories_screens/categories_page2.dart';
import 'package:trip_plannerx/screens/home/categories_screens/categories_page3.dart';
import 'package:trip_plannerx/screens/home/categories_screens/categories_page4.dart';
import 'package:trip_plannerx/screens/home/categories_screens/categoies_page5.dart';
import 'package:trip_plannerx/screens/home/categories_screens/catergories_page0.dart';
import 'package:trip_plannerx/screens/home/dream_destination.dart';

class HomeScreen extends StatefulWidget {
  final List<String> titles;
  final List<String> imageUrls;
  final List<String> descriptions;

  const HomeScreen({
    super.key,
    required this.titles,
    required this.imageUrls,
    required this.descriptions,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> images = [
    "https://as1.ftcdn.net/v2/jpg/01/40/51/56/1000_F_140515612_0MMpqpsIvs6xno5YXmPVy9FUmZ4uLnFB.jpg",
    "https://as2.ftcdn.net/v2/jpg/03/04/01/79/1000_F_304017914_06ibltT3eX4UID80q0dSUybLsrfzUubL.jpg",
    // "https://th-thumbnailer.cdn-si-edu.com/0Tog4P1WeTD51sLUT4zUW4z-A-o=/1000x750/filters:no_upscale()/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/morning-on-the-Ganges-River-Varanasi-631.jpg"
    "https://media.istockphoto.com/id/537988165/photo/varanasi.jpg?s=1024x1024&w=is&k=20&c=zlypUzvUt1fFpvA7ESTKB6UE4KEY7paAizZWVhQmz2E="
  ];

  final List<String> names = ['Goa', 'Manali', 'Varanasi'];

  final List<String> pics = [
    "https://images.unsplash.com/photo-1566679056462-2075774c8c07?q=80&w=875&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    // "https://www.fao.org/images/newsroomlibraries/breafing-notes/36949400340_030e4ae5f9_oab4ccd35-fd6a-4230-bd2e-f0113f50357d.jpg?sfvrsn=426ca1c_3",
    "https://media.istockphoto.com/id/1611151233/photo/lakes-of-alaska-in-summer.jpg?s=2048x2048&w=is&k=20&c=n8DBdjH7FZR-8BRP4dkJEEDPhRvSKwn9ac0zxO6eJSs=",
    "https://media.istockphoto.com/id/970240438/photo/green-tree-on-island-in-middle-of-the-deep-blue-sea-ocean.jpg?s=2048x2048&w=is&k=20&c=JszTHj4dYMaaDmdHXI5tm6qPvhRGaUK9vcREnkn1sQs=",
    "https://media.istockphoto.com/id/577303888/photo/salto-80m-waterfall-in-chapada-dos-veadeiros-goias-brazil.jpg?s=2048x2048&w=is&k=20&c=6rVsOn31Phdp5IAd0gUW31jf6X4cECuKUcHbtLXadEU=",
    "https://media.istockphoto.com/id/1466527775/photo/ponquogue-beach-in-the-hamptons.jpg?s=2048x2048&w=is&k=20&c=eVghKy9FKZvmZ97fymkRSNEXv2WKR9OdTFk4O5ebte0=",
    "https://st.adda247.com/https://adda247jobs-wp-assets-prod.adda247.com/jobs/wp-content/uploads/sites/2/2022/12/31112725/01-8-1.png"
  ];

  final List<String> texts = [
    'Mountains',
    'Wild',
    'Islands',
    'Waterfalls',
    'Beaches',
    'Monuments'
  ];

  List<Widget> nav = [
    const Pagezero(),
    const PageOne(),
    const PageTwo(),
    const PageThree(),
    const PageFour(),
    const PageFive()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip PlannerX'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 40,
              height: 30,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DreamDestination()));
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(4),
                  backgroundColor: Colors.white,
                ),
                child: const Icon(
                  Icons.add_location_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Trending Now',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 20),
                CarouselSlider(
                  items: images.asMap().entries.map(
                    (entry) {
                      final int index = entry.key;
                      final String image = entry.value;
                      final String name = names[index];
                      return Builder(builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 218, 216, 207),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/image/pngtree-gray-network-placeholder-png-image_3416659.jpg',
                                    image: image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Text(
                                    name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                  ).toList(),
                  options: CarouselOptions(
                    height: 300,
                    aspectRatio: 15 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: Text(
                    'Popular Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 2,crossAxisSpacing: 10,mainAxisSpacing: 10),
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (ctx) => nav[index]),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 218, 216, 207),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/image/pngtree-gray-network-placeholder-png-image_3416659.jpg',
                                    image: pics[index],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Text(
                                    texts[index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                      );
                      
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTrip()));
        },
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
