import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trip_plannerx/model/favorite_db.dart';
import 'package:trip_plannerx/screens/home/categories_screens/catergories_page0.dart';
import 'package:trip_plannerx/screens/home/inside_categories_screens/description_page0.dart';

class Category {
  final String name;
  final List<String> places;
  final List<String> images;
  final List<String> descriptions;

  Category({
    required this.name,
    required this.places,
    required this.images,
    required this.descriptions,
  });
}

class FavoritePlacesPage extends StatefulWidget {
  const FavoritePlacesPage({Key? key}) : super(key: key);

  @override
  _FavoritePlacesPageState createState() => _FavoritePlacesPageState();
}

class _FavoritePlacesPageState extends State<FavoritePlacesPage> {
  Box<Favorite>? fava;

  final List<Category> categories = [
    Category(
      name: 'Mountains',
      places: ['Manali', 'Top station', 'Illikalkallu', 'Dophin Nose'],
      images: [
        "https://static2.tripoto.com/media/filter/tst/img/415096/TripDocument/1550220068_1550219789211.jpg",
    "https://as1.ftcdn.net/v2/jpg/03/36/74/40/1000_F_336744051_8SykhW07UktuizuLxYQlVHDjlwjYZWdY.jpg",
    "https://as2.ftcdn.net/v2/jpg/02/08/11/25/1000_F_208112518_FGFq0n4s6P8CTAJll6hcfH4XIBaeoWWu.jpg",
    "https://t3.ftcdn.net/jpg/05/29/38/48/240_F_529384837_hAXG0iWvGX93B96aqkA6kwJMUjD9tqsM.jpg"
      ],
      descriptions: [
        'Manali is synonymous streams and birdsong, forests and orchards and grandees of snow-capped mountains. Manali is the real starting point of an ancient trade route which crosses the Rohtang and Baralacha passes, and runs via Lahul and Ladakh to Kashmir while divergent road connects it with Spiti.',
        'Top Station is a tourist destination located in Theni district of Tamil nadu. Top Station is notable as the historic transshipment location for Kannan Devan tea delivered there from Munnar and Madupatty by railway and then down by ropeway to Kottagudi. This area is popular for the rare Neelakurinji flowers. The Kurinjimala Sanctuary is nearby. Top Station is the western entrance to the planned Palani Hills National Park.',
        'Illikkal Kallu is a Thalanadu located on top of the Illickal Malaa in the Kottayam district of Kerala, India.The distance from kottayam railway station to illikal kallu is 57km. Situated at around 3500 feet above sea level, Illickal Kallu is a major tourist attraction in Thalanadu. L. S. G.D., Thalanadu village of Meenachil taluk. Only one half of the original rock remains, as the other half of the rock has fallen off. The nearest town is Teekoy. Numerous mountain streams originate from this peak and flow down to form the Meenachil River. ',
        'to Dolphin’s Nose, a viewpoint that offers an enthralling view of the blue mountains of Nilgiris and the lush green tea estates on its slopes. Let your eyes and mind freely wander along the marvellous view of unending plains and lush green hillocks from the vantage point Dolphin Nose offers. At 6600 ft above sea level, the view from the dolphin’s nose is breath-taking. An ideal spot for those interested in trekking, the trail to the Dolphin’s Nose covers a distance of 3 kms in the Palani Hill Range. This view point is a favourite among the tourists who come to adore the glory of the Princess of hill-stations. Kodaikanal proudly fosters this location as an ideal spot from which one may marvel at the glory of its lush green landscapes, rough terrains, and the rugged charm of the towns.'
      ],
    ),
    Category(
      name: 'Wild',
      places: [
        'Gir National Park',
        'Manas National Park',
        'The Great Himalayan National Park'
      ],
      images: [
        "https://t3.ftcdn.net/jpg/06/76/89/58/240_F_676895828_OIhv4HfzQ00TcTjyFAYB6pR1xHeG3lSs.jpg",
    "https://as2.ftcdn.net/v2/jpg/06/59/22/57/1000_F_659225777_0OBnOSjKIWUZssAkb9FqO3ys16hetiCC.jpg",
    "https://img.traveltriangle.com/blog/wp-content/uploads/2018/12/great-himalayan-national-park-stay-tent5.jpg"
      ],
      descriptions: [
        "Gir National Park and Wildlife Sanctuary, also known as Sasan Gir, is a forest, national park, and wildlife sanctuary near Talala Gir in Gujarat, India. It is located 43 km (27 mi) north-east of Somnath, 65 km (40 mi) south-east of Junagadh and 60 km (37 mi) south-west of Amreli. It was established in 1965 in the erstwhile Nawab of Junagarh's private hunting area, with a total area of 1,410.30 km2 (544.52 sq mi), of which 258.71 km2 (99.89 sq mi) is fully protected as a national park as wildlife sanctuary.It is part of the Khathiar-Gir dry deciduous forests ecoregion.",
        'Manas National Park is a national park, Project Tiger reserve, and an elephant reserve in Assam, India. Located in the Himalayan foothills, it borders the Royal Manas National Park in Bhutan. The park is known for its rare and endangered endemic wildlife such as the Assam roofed turtle, hispid hare, golden langur and pygmy hog. Manas is also famous for its population of the wild water buffalo. Because of its exceptional biodiversity, scenery, and variety of habitats, Manas National Park is a biosphere reserve and a UNESCO World Heritage Site.',
       "The Great Himalayan National Park is set amid the snow-capped Himalayas, and serves as a rich habitat for alpine flora and fauna. Situated in the Kullu region, it was declared a national park in 1999 It is blessed with more than 375 fauna species, including 181 species of birds, and 31 species of mammals, and a visit to this place is no less than enriching. Some of the wildlife that you can easily spot here include blue sheep, snow leopard, Himalayan brown bear, Himalayan tahr, and more."

      ],
    ),
    Category(name: 'Island', places: [
      'Swaraj Dweep',
      'lakshadweep',
      'Munroe'
    ], images: [
      "https://as1.ftcdn.net/v2/jpg/08/07/67/12/1000_F_807671278_Q2B3n1ELvT5AVAiWxyXWCzTx3rVnsdsV.jpg",
    "https://as1.ftcdn.net/v2/jpg/06/05/49/02/1000_F_605490260_KXNxcuxG7a7EdNiBoRkxUP6NXldY08zw.jpg",
    "https://as1.ftcdn.net/v2/jpg/05/06/04/76/1000_F_506047644_26rZ2OWXXTTmRwgA50aJqZDvlmGeXZPO.jpg"
    ], descriptions: [
      "Swaraj Dweep is a picturesque natural paradise with beautiful white sandy beaches, rich coral reefs and lush green forest. It is one of the populated islands in the Andaman group with an area of 113 sq. km. and is located 39 km of north-east of Port Blair.",
      "India's smallest Union Territory Lakshadweep is an archipelago consisting of 36 islands with an area of 32 sq km. It is a uni-district Union Territory and is comprised of 12 atolls, three reefs, five submerged banks and ten inhabited islands. The islands comprise of 32 sq km.",
      "Munroe Island or Mundrothuruthu is an inland island group located at the confluence of Ashtamudi Lake and the Kallada River, in Kollam district, Kerala, South India. It is a group of eight small islets comprising a total area of about 13.4 km2. The island, accessible by road, rail and inland water navigation, is about 25 kilometres (16 mi) from Kollam by road, 38 kilometres (24 mi) north from Paravur, 12 kilometres (7.5 mi) west from Kundara and about 25 kilometres (16 mi) from Karunagapally. As of the 2011 Indian census, the administrative village of Mundrothuruth (which includes nearby small villages as well) has a total population of 9599, consisting of 4636 males and 4963 females. This island is also known as Sinking Island of Kerala"
    ]),
    Category(name: 'WaterFalls', places: [
      "Athirapally Waterfalls",
      "Jog Falls",
      "Dudhsagar Falls"
    ], images: [
      "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Athirapally_Waterfalls_after_the_Monsoons.jpg/1200px-Athirapally_Waterfalls_after_the_Monsoons.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAgZVIo9UFNaNbWJze59Bl55ibbTMeEzaiMA&s",
    "https://media.istockphoto.com/id/492804402/photo/beautiful-view-of-the-dudhsagar-waterfall-in-goa-india.jpg?s=612x612&w=is&k=20&c=_Z7eaJeri95jwnp4h53CsQu69BNnyl2ikHxUoG0iTys="
    ], descriptions: [
      "Athirappilly Falls, is situated in Athirappilly Panchayat, Chalakudy Taluk, Thrissur District of Kerala, India on the Chalakudy River, which originates from the upper reaches of the Western Ghats at the entrance to the Sholayar ranges.It is the largest waterfall in Kerala, which stands tall at 80 fee",
      "Jog Falls is a waterfall on the Sharavati river located in Siddapura taluk, Uttara Kannada District and its view point located in Shimoga district of Karnataka, India. It is the second highest plunge waterfall in India. It is a segmented waterfall which depends on rain and season to become a plunge waterfall.",
      "Dudhsagar Waterfall is situated inside the Bhagwan Mahavir wildlife sanctuary in Sanguem district of Goa close to the border with Karnataka. It is about 60 km from state capital Panaji. Water plummets from a height of over 1,000 ft to form one of the most amazing natural phenomena in Goa."
    ]),
    Category(name: 'Beaches', places: [
      'Varkala',
      'Kuzhupilly Beach',
      'Kovalam Beach',
      'Goa'
    ], images: [
     "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/c8/f1/cb/varkala-beach.jpg?w=1200&h=-1&s=1",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRx6J0cyQrHe6kAGLBeAmgr8vrHNoGtGtQsxA&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdcCpLEM5bIvuMfzhknM3JdfK3Vmc9GqTdpw&s",
    "https://as1.ftcdn.net/v2/jpg/01/40/51/56/1000_F_140515612_0MMpqpsIvs6xno5YXmPVy9FUmZ4uLnFB.jpg"
    ], descriptions: [
      "Varkala Beach, also known as Papanasam Beach, is a stunning coastal gem located in the town of Varkala, Kerala. The beach is famous for its serene atmosphere, golden sands, and dramatic cliffs. The name Papanasam means washing away sins, as it is believed that taking a dip in the waters here can cleanse one's soul.",
      "Kuzhupilly beach situated at Vypeen in Kochi in its pristine splendour is a literal paradise for swimmers. Its white and sandy shores form the perfect backdrop for a relaxing dip. The beach will also host kite festivals are occasionally.",
      "Kovalam is an internationally renowned beach with three adjacent crescent beaches. It has been a favourite haunt of tourists since the 1930s. A massive rocky promontory on the beach has created a beautiful bay of calm waters ideal for sea bathing. The leisure options at this beach are plenty and diverse.",
      "The state's white-sand beaches, on the other hand, are made from a mix of sand, small stones and coral. Many beaches offer water sports, such as parasailing, windsurfing and kayaking. Beach lodging is quite popular in Goa due to the high tourist traffic."
    ]),
    Category(name: 'Monuments', places: [
      'Taj Mahal',
      'Qutub Minar',
      'Red Fort',
      'Varanasi'
    ], images: [
     "https://miro.medium.com/v2/resize:fit:1400/format:webp/0*uEnJuRoUCKEUZZI_.jpg",
    "https://miro.medium.com/v2/resize:fit:1400/format:webp/0*RcUbE5L_S9-L_lXV.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROcFcTbfKS_bHqkS8LE4wXT19r3uHtJBk_Fw&s",
    "https://media.istockphoto.com/id/537988165/photo/varanasi.jpg?s=1024x1024&w=is&k=20&c=zlypUzvUt1fFpvA7ESTKB6UE4KEY7paAizZWVhQmz2E=",
    ], descriptions: [
      " The Taj Mahal is an ivory-white marble mausoleum on the south bank of the Yamuna river in the Indian city of Agra. It was commissioned in 1632 by the Mughal emperor, Shah Jahan (reigned from 1628 to 1658), to house the tomb of his favourite wife, Mumtaz Mahal.",
      "Built of red and buff sandstone and eloquently carved with inscriptional bands, the Qutb Minar is the tallest masonry tower in India, measuring 72.5 metres high, with projecting balconies for calling all Muadhdhin to prayer. An iron pillar in the courtyard gave the mosque a unique Indian aesthetic.",
      "The Red Fort Complex was built as the palace fort of Shahjahanabad-the new capital of the fifth Mughal Emperor of India, Shah Jahan. Named for its massive enclosing walls of red sandstone, it is adjacent to an older fort, the Salimgarh, built by Islam Shah Suri in 1546, with which it forms the Red Fort Complex.",
      "The land of Varanasi (Kashi) has been the ultimate pilgrimage spot for Hindus for ages. Hindus believe that one who is graced to die on the land of Varanasi would attain salvation and freedom from the cycle of birth and re-birth. Abode of Lord Shiva and Parvati, the origins of Varanasi are yet unknown."
    ]),
  ];

  @override
  void initState() {
    super.initState();
    openBox();
  }

  void openBox() async {
    fava = await Hive.openBox<Favorite>('place');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Places'),
      ),
      body: fava == null
          ? const Center(child: CircularProgressIndicator())
          : ValueListenableBuilder(
              valueListenable: fava!.listenable(),
              builder: (context, Box<Favorite> box, child) {
                if (box.values.isEmpty) {
                  return const Center(child: Text('No favorites added.'));
                } else {
                  return ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      final favorite = box.getAt(index);
                      // Find the category of the favorite place
                      final category = categories.firstWhere(
                        (cat) =>
                            favorite?.place != null &&
                            cat.places.contains(favorite!.place),
                        orElse: () => Category(
                          name: 'Unknown',
                          places: [],
                          images: [],
                          descriptions: [],
                        ),
                      );

                      // Find the index of the favorite place in the category
                      int placeIndex = category.places.indexOf(
                        favorite?.place ?? '',
                      );
                      if (placeIndex == -1) return Container();

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DescriptionPage0(
                                title: category.places[placeIndex],
                                imageUrl: category.images[placeIndex],
                                description: category.descriptions[placeIndex],
                                latitude: getLatitude(index),
                                longitude: getLongitude(index),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(category.places[placeIndex]),
                            leading: CircleAvatar(
                              radius: 25,
                              child: ClipOval(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: FadeInImage.assetNetwork(
                                    placeholder:
                                        'assets/image/pngtree-gray-network-placeholder-png-image_3416659.jpg',
                                    image: category.images[placeIndex],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            trailing: IconButton(
                              color: Colors.red,
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                showDeleteDialog(context, index, box);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
    );
  }

  void showDeleteDialog(BuildContext context, int index, Box<Favorite> box) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Favorite"),
          content: const Text(
              "Are you sure you want to delete this favorite place?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                box.deleteAt(index);
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
