import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trip_plannerx/model/favorite_db.dart';
import 'package:trip_plannerx/screens/home/inside_categories_screens/description_page0.dart';

double getLatitude(int index) {
  switch (index) {
    case 0:
      return 32.2574; // Manali
    case 1:
      return 10.12338; // Top station
    case 2:
      return 9.75333; // Illikalkallu
    case 3:
      return 11.36923; // Dophin Nose
    default:
      return 0.0;
  }
}

double getLongitude(int index) {
  switch (index) {
    case 0:
      return 77.1748; // Manali
    case 1:
      return 77.24484; // Top station
    case 2:
      return 76.8211; // Illikalkallu
    case 3:
      return 76.85922; // Dophin Nose
    default:
      return 0.0;
  }
}

class Pagezero extends StatefulWidget {
  const Pagezero({super.key});

  @override
  State<Pagezero> createState() => _PagezeroState();
}

class _PagezeroState extends State<Pagezero> {
  Box<Favorite>? fava;

  final List<String> img = [
    "https://static2.tripoto.com/media/filter/tst/img/415096/TripDocument/1550220068_1550219789211.jpg",
    "https://as1.ftcdn.net/v2/jpg/03/36/74/40/1000_F_336744051_8SykhW07UktuizuLxYQlVHDjlwjYZWdY.jpg",
    "https://as2.ftcdn.net/v2/jpg/02/08/11/25/1000_F_208112518_FGFq0n4s6P8CTAJll6hcfH4XIBaeoWWu.jpg",
    "https://t3.ftcdn.net/jpg/05/29/38/48/240_F_529384837_hAXG0iWvGX93B96aqkA6kwJMUjD9tqsM.jpg"
  ];

  final List<String> place = [
    'Manali',
    'Top station',
    'Illikalkallu',
    'Dophin Nose'
  ];

  final List<String> descriptions = [
    'Manali is synonymous streams and birdsong, forests and orchards and grandees of snow-capped mountains. Manali is the real starting point of an ancient trade route which crosses the Rohtang and Baralacha passes, and runs via Lahul and Ladakh to Kashmir while divergent road connects it with Spiti.',
    'Top Station is a tourist destination located in Theni district of Tamil nadu. Top Station is notable as the historic transshipment location for Kannan Devan tea delivered there from Munnar and Madupatty by railway and then down by ropeway to Kottagudi. This area is popular for the rare Neelakurinji flowers. The Kurinjimala Sanctuary is nearby. Top Station is the western entrance to the planned Palani Hills National Park.',
    'Illikkal Kallu is a Thalanadu located on top of the Illickal Malaa in the Kottayam district of Kerala, India.The distance from kottayam railway station to illikal kallu is 57km. Situated at around 3500 feet above sea level, Illickal Kallu is a major tourist attraction in Thalanadu. L. S. G.D., Thalanadu village of Meenachil taluk. Only one half of the original rock remains, as the other half of the rock has fallen off. The nearest town is Teekoy. Numerous mountain streams originate from this peak and flow down to form the Meenachil River. ',
    'to Dolphin’s Nose, a viewpoint that offers an enthralling view of the blue mountains of Nilgiris and the lush green tea estates on its slopes. Let your eyes and mind freely wander along the marvellous view of unending plains and lush green hillocks from the vantage point Dolphin Nose offers. At 6600 ft above sea level, the view from the dolphin’s nose is breath-taking. An ideal spot for those interested in trekking, the trail to the Dolphin’s Nose covers a distance of 3 kms in the Palani Hill Range. This view point is a favourite among the tourists who come to adore the glory of the Princess of hill-stations. Kodaikanal proudly fosters this location as an ideal spot from which one may marvel at the glory of its lush green landscapes, rough terrains, and the rugged charm of the towns.'
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
        title: const Text('Mountains'),
      ),
      body: SafeArea(
        child: GridView.builder(
          scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 3),
          itemCount: place.length,
          itemBuilder: (context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DescriptionPage0(
                      title: place[index],
                      imageUrl: img[index],
                      description: descriptions[index],
                      latitude: getLatitude(index),
                      longitude: getLongitude(index),
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
                height: 250,
            
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/image/pngtree-gray-network-placeholder-png-image_3416659.jpg', // Your placeholder image asset
                          image: img[index],
                          fit: BoxFit.fill,
                          // width: double.infinity,
                          // height: 120,
                          // width: 300,
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
