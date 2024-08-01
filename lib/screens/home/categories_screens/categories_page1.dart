import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trip_plannerx/model/favorite_db.dart';
import 'package:trip_plannerx/screens/home/inside_categories_screens/description_page1.dart';

double getLatitude1(int index) {
  switch (index) {
    case 0:
      return 21.1240;
    case 1:
      return 26.6593;
    case 2:
      return 31.7414;
    default:
      return 0.0;
  }
}

double getLongitude2(int index) {
  switch (index) {
    case 0:
      return 70.8022;
    case 1:
      return 91.0159;
    case 2:
      return 77.3684;
    default:
      return 0.0;
  }
}

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  Box<Favorite>? fava;

  final List<String> img = [
    "https://t3.ftcdn.net/jpg/06/76/89/58/240_F_676895828_OIhv4HfzQ00TcTjyFAYB6pR1xHeG3lSs.jpg",
    "https://as2.ftcdn.net/v2/jpg/06/59/22/57/1000_F_659225777_0OBnOSjKIWUZssAkb9FqO3ys16hetiCC.jpg",
    "https://img.traveltriangle.com/blog/wp-content/uploads/2018/12/great-himalayan-national-park-stay-tent5.jpg"
  ];

  final List<String> place = [
    'Gir National Park',
    'Manas National Park',
    'The Great Himalayan National Park'
  ];

  final List<String> descriptions = [
    "Gir National Park and Wildlife Sanctuary, also known as Sasan Gir, is a forest, national park, and wildlife sanctuary near Talala Gir in Gujarat, India. It is located 43 km (27 mi) north-east of Somnath, 65 km (40 mi) south-east of Junagadh and 60 km (37 mi) south-west of Amreli. It was established in 1965 in the erstwhile Nawab of Junagarh's private hunting area, with a total area of 1,410.30 km2 (544.52 sq mi), of which 258.71 km2 (99.89 sq mi) is fully protected as a national park as wildlife sanctuary. It is part of the Khathiar-Gir dry deciduous forests ecoregion.",
    'Manas National Park is a national park, Project Tiger reserve, and an elephant reserve in Assam, India. Located in the Himalayan foothills, it borders the Royal Manas National Park in Bhutan. The park is known for its rare and endangered endemic wildlife such as the Assam roofed turtle, hispid hare, golden langur and pygmy hog. Manas is also famous for its population of the wild water buffalo. Because of its exceptional biodiversity, scenery, and variety of habitats, Manas National Park is a biosphere reserve and a UNESCO World Heritage Site.',
    "The Great Himalayan National Park is a national park in India, located in Banjar sub-division of Kullu in the state of Himachal Pradesh. The park was established in 1984 and is spread over an area of 1171 km2; elevations within the park range between 1500 and 6000 m. The Great Himalayan National Park is a habitat to numerous flora and more than 375 fauna species, including approximately 31 mammals, 181 birds, 3 reptiles, 9 amphibians, 11 annelids, 17 mollusks and 127 insects. They are protected under the strict guidelines of the Wildlife Protection Act of 1972; hence any sort of hunting is not permitted."
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
        title: const Text('Wild'),
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
                    builder: (context) => Descriptionpage1(
                      title: place[index],
                      imageUrl: img[index],
                      description: descriptions[index],
                      latitude: getLatitude1(index),
                      longitude: getLongitude2(index),
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(20),
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
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/image/pngtree-gray-network-placeholder-png-image_3416659.jpg',
                          image: img[index],
                          fit: BoxFit.fill,
                          placeholderFit: BoxFit.fill,
                          imageErrorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return Container(
                              color: Colors.grey,
                              child: const Center(
                                child: Text(
                                  'Image not loaded',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Text(
                        place[index],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        onPressed: () async {
                          bool currentlyFavorite = isFavorite[place[index]] ?? false;
                          if (currentlyFavorite) {
                            var key = fava?.keys.firstWhere(
                                (key) => fava?.get(key)?.place == place[index],
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
