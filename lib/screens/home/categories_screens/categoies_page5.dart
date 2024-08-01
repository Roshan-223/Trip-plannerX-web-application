import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trip_plannerx/model/favorite_db.dart';
import 'package:trip_plannerx/screens/home/inside_categories_screens/description_page5.dart';

double getLatitude9(int index) {
  switch (index) {
    case 0:
      return 27.173891;
    case 1:
      return 28.5245;
    case 2:
      return 28.6562;
    case 3:
      return 25.3176;
    default:
      return 0.0;
  }
}

double getLongitude10(int index) {
  switch (index) {
    case 0:
      return 78.042068;
    case 1:
      return 77.1855;
    case 2:
      return 77.2410;
    case 3:
      return 82.9739;
    default:
      return 0.0;
  }
}

class PageFive extends StatefulWidget {
  const PageFive({super.key});

  @override
  State<PageFive> createState() => _PageFiveState();
}

class _PageFiveState extends State<PageFive> {
  Box<Favorite>? fava;

  final List<String> img = [
    "https://miro.medium.com/v2/resize:fit:1400/format:webp/0*uEnJuRoUCKEUZZI_.jpg",
    "https://miro.medium.com/v2/resize:fit:1400/format:webp/0*RcUbE5L_S9-L_lXV.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROcFcTbfKS_bHqkS8LE4wXT19r3uHtJBk_Fw&s",
    "https://media.istockphoto.com/id/537988165/photo/varanasi.jpg?s=1024x1024&w=is&k=20&c=zlypUzvUt1fFpvA7ESTKB6UE4KEY7paAizZWVhQmz2E=",
  ];

  final List<String> place = [
    'Taj Mahal',
    'Qutub Minar',
    'Red Fort',
    'Varanasi'
  ];

  final List<String> description = [
    " The Taj Mahal is an ivory-white marble mausoleum on the south bank of the Yamuna river in the Indian city of Agra. It was commissioned in 1632 by the Mughal emperor, Shah Jahan (reigned from 1628 to 1658), to house the tomb of his favourite wife, Mumtaz Mahal.",
    "Built of red and buff sandstone and eloquently carved with inscriptional bands, the Qutb Minar is the tallest masonry tower in India, measuring 72.5 metres high, with projecting balconies for calling all Muadhdhin to prayer. An iron pillar in the courtyard gave the mosque a unique Indian aesthetic.",
    "The Red Fort Complex was built as the palace fort of Shahjahanabad – the new capital of the fifth Mughal Emperor of India, Shah Jahan. Named for its massive enclosing walls of red sandstone, it is adjacent to an older fort, the Salimgarh, built by Islam Shah Suri in 1546, with which it forms the Red Fort Complex.",
    "The land of Varanasi (Kashi) has been the ultimate pilgrimage spot for Hindus for ages. Hindus believe that one who is graced to die on the land of Varanasi would attain salvation and freedom from the cycle of birth and re-birth. Abode of Lord Shiva and Parvati, the origins of Varanasi are yet unknown."
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
        title: const Text('Monuments'),
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
                    builder: (context) => DescriptionPage5(
                      title: place[index],
                      imageUrl: img[index],
                      description: description[index],
                      latitude: getLatitude9(index),
                      longitude: getLongitude10(index),
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
