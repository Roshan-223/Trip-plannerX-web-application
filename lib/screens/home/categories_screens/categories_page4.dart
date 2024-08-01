import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trip_plannerx/model/favorite_db.dart';
import 'package:trip_plannerx/screens/home/inside_categories_screens/description_page4.dart';

double getLatitude7(int index) {
  switch (index) {
    case 0:
      return 8.73635;
    case 1:
      return 10.10201;
    case 2:
      return 8.38911;
    case 3:
      return 15.2993;
    default:
      return 0.0;
  }
}

double getLongitude8(int index) {
  switch (index) {
    case 0:
      return 76.70328;
    case 1:
      return 76.18905;
    case 2:
      return 76.97609;
    case 3:
      return 74.1240;
    default:
      return 0.0;
  }
}

class PageFour extends StatefulWidget {
  const PageFour({super.key});

  @override
  State<PageFour> createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  Box<Favorite>? fava;
  final List<String> img = [
    "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/c8/f1/cb/varkala-beach.jpg?w=1200&h=-1&s=1",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRx6J0cyQrHe6kAGLBeAmgr8vrHNoGtGtQsxA&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdcCpLEM5bIvuMfzhknM3JdfK3Vmc9GqTdpw&s",
    "https://as1.ftcdn.net/v2/jpg/01/40/51/56/1000_F_140515612_0MMpqpsIvs6xno5YXmPVy9FUmZ4uLnFB.jpg"
  ];

  final List<String> place = [
    'Varkala',
    'Kuzhupilly Beach',
    'Kovalam Beach',
    'Goa'
  ];

  final List<String> description = [
    "Varkala Beach, also known as Papanasam Beach, is a stunning coastal gem located in the town of Varkala, Kerala. The beach is famous for its serene atmosphere, golden sands, and dramatic cliffs. The name Papanasam means washing away sins, as it is believed that taking a dip in the waters here can cleanse one's soul.",
    "Kuzhupilly beach situated at Vypeen in Kochi in its pristine splendour is a literal paradise for swimmers. Its white and sandy shores form the perfect backdrop for a relaxing dip. The beach will also host kite festivals are occasionally.",
    "Kovalam is an internationally renowned beach with three adjacent crescent beaches. It has been a favourite haunt of tourists since the 1930s. A massive rocky promontory on the beach has created a beautiful bay of calm waters ideal for sea bathing. The leisure options at this beach are plenty and diverse.",
    "The state's white-sand beaches, on the other hand, are made from a mix of sand, small stones and coral. Many beaches offer water sports, such as parasailing, windsurfing and kayaking. Beach lodging is quite popular in Goa due to the high tourist traffic."
  ];

  final Map<String, bool> isFavorite = {};

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    fava = await Hive.openBox<Favorite>('place');
    loadFavorites();
  }

  void loadFavorites() {
    final favoritePlaces =
        fava?.values.map((favorite) => favorite.place).toList() ?? [];
    setState(() {
      for (var placeName in place) {
        isFavorite[placeName] = favoritePlaces.contains(placeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beaches'),
      ),
      body: SafeArea(
        child: GridView.builder(
          scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      
                    ),
          itemCount: place.length,
          itemBuilder: (context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DecriptionPage4(
                      title: place[index],
                      imageUrl: img[index],
                      description: description[index],
                      latitude: getLatitude7(index),
                      longitude: getLongitude8(index),
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 218, 216, 207),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                height: 200,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/image/pngtree-gray-network-placeholder-png-image_3416659.jpg',
                        image: img[index],
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                place[index],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  bool currentlyFavorite =
                                      isFavorite[place[index]] ?? false;
                                  if (currentlyFavorite) {
                                    var key = fava?.keys.firstWhere(
                                        (key) =>
                                            fava?.get(key)?.place == place[index],
                                        orElse: () => null);
                                    if (key != null) {
                                      await fava?.delete(key);
                                    }
                                  } else {
                                    Favorite favorite = Favorite(place[index]);
                                    await fava?.add(favorite);
                                  }

                                  setState(() {
                                    isFavorite[place[index]] = !currentlyFavorite;
                                  });
                                },
                                icon: Icon(
                                  isFavorite[place[index]] == true
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite[place[index]] == true
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
