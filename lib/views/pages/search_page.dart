import 'package:ecommrac_app/models/product_item_model.dart';
import 'package:ecommrac_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> lastSearches = [
    'apple',
    'banana',
    'Pack of Orange',
    'Sweet shirt'
  ];
  List<ProductItemModel> popularProducts =
      dummyProducts; // Use the appropriate list
  List<String> searchResults = []; // Initialize with your search results data
  String query = '';

  void addSearchTerm(String term) {
    setState(() {
      lastSearches.remove(term);
      lastSearches.insert(0, term);
    });
  }

  void performSearch(String query) {
    print('Performing search for: $query');
    addSearchTerm(query);
    setState(() {
      searchResults = [
        'Result 1',
        'Result 2',
        'Result 3'
      ]; // Placeholder for search results
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
        ),
        elevation: 2, // App bar shadow
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                searchResults.clear();
                query = '';
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Search TextField
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Search',
                  hintText: 'What are you looking for?',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
                onSubmitted: (String submittedStr) {
                  performSearch(submittedStr);
                },
                onChanged: (String newQuery) {
                  // If you want to perform search on each change, call performSearch here

                  setState(() {
                    query = newQuery;
                  });
                },
              ),
              const SizedBox(
                  height: 24), // Spacing between search bar and content

              // Last Searches
              if (query.isEmpty) ...[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Last Searches',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10.0,
                  children: lastSearches
                      .map((term) => Chip(
                            label: Text(
                              term,
                              style: const TextStyle(
                                  color: AppColors
                                      .grey), // Custom text style if needed
                            ),
                            deleteIcon: const Icon(
                              Icons.close,
                              color: AppColors.grey, // Custom delete icon color
                            ),
                            onDeleted: () {
                              setState(() {
                                lastSearches.remove(term);
                              });
                            },
                            // Custom chip background color
                            shape: StadiumBorder(
                                side: BorderSide(
                                    color: AppColors
                                        .grey3)), // Custom shape with border side
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16), // Spacing between sections
              ],

              // Popular Searches
              if (query.isEmpty) ...[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Popular Searches',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                // Here we build the popular search items using the list of ProductItemModel objects
                ...popularProducts
                    .map((product) => buildPopularSearchItem(product))
                    .toList(),
                const SizedBox(height: 24), // Spacing before the search results
              ],

              // Search Results
              ...searchResults.map((result) => ListTile(
                    title: Text(result),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build each popular search item
  Widget buildPopularSearchItem(ProductItemModel product) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              product.imgUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("\$${product.price.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
            // Placeholder for a tag, you will need to implement a mechanism to determine the tag label and color
            const Chip(
              label: Text('NEW', style: TextStyle(color: Colors.white)),
              backgroundColor: AppColors.primary, // Example tag color
            ),
          ],
        ),
      ),
    );
  }
}
