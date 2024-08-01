import 'package:flutter/material.dart';
import 'package:trip_plannerx/screens/home/bottom_navigation_screens/search_place.dart';
import 'package:trip_plannerx/screens/home/categories_screens/catergories_page0.dart';
import 'package:trip_plannerx/screens/home/inside_categories_screens/description_page0.dart';

class BottomSearch extends StatefulWidget {
  const BottomSearch({super.key});

  @override
  _BottomSearchState createState() => _BottomSearchState();
}

class _BottomSearchState extends State<BottomSearch> {
  final TextEditingController searchController = TextEditingController();
  List<Place> filteredPlaces = places;

  void _updateSearchResults(String query) {
    setState(() {
      filteredPlaces = places
          .where((place) =>
              place.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search your destination"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Search your destination",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    clearSearch();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              onChanged: _updateSearchResults,
              style: const TextStyle(
                  fontSize: 15), // Update search results on text change
            ),
            Expanded(
              child: filteredPlaces.isEmpty
                  ? const Center(
                      // Display a message if no results found
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 50,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "No results found",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredPlaces.length,
                      itemBuilder: (context, index) {
                        final place = filteredPlaces[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: ClipOval(
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/image/pngtree-gray-network-placeholder-png-image_3416659.jpg',
                                image: place.imageUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                imageErrorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/image/pngtree-gray-network-placeholder-png-image_3416659.jpg',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                            title: Text(place.title),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DescriptionPage0(
                                    title: place.title,
                                    imageUrl: place.imageUrl,
                                    description: place.description,
                                    latitude: getLatitude(index),
                                    longitude: getLatitude(index),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
      filteredPlaces = places;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
