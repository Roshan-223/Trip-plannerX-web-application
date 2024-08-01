import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trip_plannerx/model/favorite_db.dart';
import 'package:trip_plannerx/screens/home/inside_categories_screens/decription_page2.dart';

double getLatitude3(int index) {
  switch (index) {
    case 0:
      return 11.6084;
    case 1:
      return 10.5667;
    case 2:
      return 8.99313;
    default:
      return 0.0;
  }
}

double getLongitude4(int index) {
  switch (index) {
    case 0:
      return 92.3484;
    case 1:
      return 72.6417;
    case 2:
      return 76.62417;
    default:
      return 0.0;
  }
}

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  Box<Favorite>? fava;

  final List<String> img = [
    "https://as1.ftcdn.net/v2/jpg/08/07/67/12/1000_F_807671278_Q2B3n1ELvT5AVAiWxyXWCzTx3rVnsdsV.jpg",
    "https://as1.ftcdn.net/v2/jpg/06/05/49/02/1000_F_605490260_KXNxcuxG7a7EdNiBoRkxUP6NXldY08zw.jpg",
    "https://as1.ftcdn.net/v2/jpg/05/06/04/76/1000_F_506047644_26rZ2OWXXTTmRwgA50aJqZDvlmGeXZPO.jpg"
  ];

  final List<String> place = ['Swaraj Dweep', 'lakshadweep', 'Munroe'];

  final List<String> description = [
    "Swaraj Dweep is a picturesque natural paradise with beautiful white sandy beaches, rich coral reefs and lush green forest. It is one of the populated islands in the Andaman group with an area of 113 sq. km. and is located 39 km of north-east of Port Blair.",
    "India's smallest Union Territory Lakshadweep is an archipelago consisting of 36 islands with an area of 32 sq km. It is a uni-district Union Territory and is comprised of 12 atolls, three reefs, five submerged banks and ten inhabited islands. The islands comprise of 32 sq km.",
    "Munroe Island or Mundrothuruthu is an inland island group located at the confluence of Ashtamudi Lake and the Kallada River, in Kollam district, Kerala, South India. It is a group of eight small islets comprising a total area of about 13.4 km2. The island, accessible by road, rail and inland water navigation, is about 25 kilometres (16 mi) from Kollam by road, 38 kilometres (24 mi) north from Paravur, 12 kilometres (7.5 mi) west from Kundara and about 25 kilometres (16 mi) from Karunagapally. As of the 2011 Indian census, the administrative village of Mundrothuruth (which includes nearby small villages as well) has a total population of 9599, consisting of 4636 males and 4963 females. This island is also known as Sinking Island of Kerala"
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
        title: const Text('Islands'),
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
                    builder: (context) => DecriptionPage2(
                      title: place[index],
                      imageUrl: img[index],
                      description: description[index],
                      latitude: getLatitude3(index),
                      longitude: getLongitude4(index),
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
