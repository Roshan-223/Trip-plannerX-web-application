import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trip_plannerx/model/favorite_db.dart';
import 'package:trip_plannerx/screens/home/inside_categories_screens/description_page3.dart';

double getLatitude5(int index) {
  switch (index) {
    case 0:
      return 10.2843; // Latitude for Athirappilly Waterfalls
    case 1:
      return 14.2222; // Latitude for Jog Falls
    case 2:
      return 15.31483; // Latitude for Dudhsagar Waterfalls
    default:
      return 0.0;
  }
}

double getLongitude6(int index) {
  switch (index) {
    case 0:
      return 76.5690; // Longitude for Athirappilly Waterfalls
    case 1:
      return 74.7941; // Longitude for Jog Falls
    case 2:
      return 74.31445; // Longitude for Dudhsagar Waterfalls
    default:
      return 0.0;
  }
}

class PageThree extends StatefulWidget {
  const PageThree({super.key});

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  Box<Favorite>? fava;

  final List<String> img = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Athirapally_Waterfalls_after_the_Monsoons.jpg/1200px-Athirapally_Waterfalls_after_the_Monsoons.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAgZVIo9UFNaNbWJze59Bl55ibbTMeEzaiMA&s",
    "https://media.istockphoto.com/id/492804402/photo/beautiful-view-of-the-dudhsagar-waterfall-in-goa-india.jpg?s=612x612&w=is&k=20&c=_Z7eaJeri95jwnp4h53CsQu69BNnyl2ikHxUoG0iTys="
  ];

  final List<String> place = [
    "Athirapally Waterfalls",
    "Jog Falls",
    "Dudhsagar Falls"
  ];

  final List<String> description = [
    "Athirappilly Falls, is situated in Athirappilly Panchayat, Chalakudy Taluk, Thrissur District of Kerala, India on the Chalakudy River, which originates from the upper reaches of the Western Ghats at the entrance to the Sholayar ranges.It is the largest waterfall in Kerala, which stands tall at 80 fee",
    "Jog Falls is a waterfall on the Sharavati river located in Siddapura taluk, Uttara Kannada District and its view point located in Shimoga district of Karnataka, India. It is the second highest plunge waterfall in India. It is a segmented waterfall which depends on rain and season to become a plunge waterfall.",
    "Dudhsagar Waterfall is situated inside the Bhagwan Mahavir wildlife sanctuary in Sanguem district of Goa close to the border with Karnataka. It is about 60 km from state capital Panaji. Water plummets from a height of over 1,000 ft to form one of the most amazing natural phenomena in Goa."
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
        title: const Text('Waterfalls'),
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
                    builder: (context) => DescriptionPage3(
                      title: place[index],
                      imageUrl: img[index],
                      description: description[index],
                      latitude: getLatitude5(index),
                      longitude: getLongitude6(index),
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
                        fit: BoxFit.cover,
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
