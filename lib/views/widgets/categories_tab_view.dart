import 'package:flutter/material.dart';

import '../../models/product_item_model.dart';

class CategoriesTabView extends StatelessWidget {
  const CategoriesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    // Generate a map of categories with their product counts
    final categoryCounts = _generateCategoryCounts(dummyProducts);

    // Check if the category list is empty
    if (categoryCounts.isEmpty) {
      return const Center(child: Text('No categories available.'));
    }

    // Using GridView.builder to create a grid of category cards
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // Number of columns
        crossAxisSpacing: 10, // Horizontal space between cards
        mainAxisSpacing: 10, // Vertical space between cards
        childAspectRatio: 3 / 2, // Aspect ratio of cards
      ),
      itemCount: categoryCounts.length, // Number of categories
      itemBuilder: (context, index) {
        // Getting the category and count
        String category = categoryCounts.keys.elementAt(index);
        int count = categoryCounts[category] ?? 0;

        // Getting the image URL for the category
        String imageUrl = _getCategoryImageUrl(category);

        // Returning a CategoryCard for each category
        return CategoryCard(
          category: category,
          count: count,
          imageUrl: imageUrl,
        );
      },
    );
  }

  // Helper function to generate category counts
  Map<String, int> _generateCategoryCounts(List<ProductItemModel> products) {
    Map<String, int> categoryCounts = {};
    for (var product in products) {
      categoryCounts.update(product.category, (value) => ++value,
          ifAbsent: () => 1);
    }
    return categoryCounts;
  }

  // Helper function to get the image URL for a given category
  String _getCategoryImageUrl(String category) {
    Map<String, String> categoryImages = {
      'Groceries':
          'https://www.thedailymeal.com/img/gallery/you-should-think-twice-about-bagging-your-own-groceries-at-the-store/intro-1681220544.jpg',
      'Clothes':
          'https://www.verywellfamily.com/thmb/vy3Au-X1TWDhdFNFcIJn_FfshMk=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/best-places-to-buy-kids-clothes-5190552-v1-d45adce7b25f414e89d16a85dc7e077f.jpg',
      'Shoes': 'https://m.media-amazon.com/images/I/71qRiovVmsL._AC_UY300_.jpg',
      'Fruits':
          'https://img.freepik.com/free-photo/vibrant-collection-healthy-fruit-vegetables-generated-by-ai_24640-80425.jpg',
      // etc.
    };
    return categoryImages[category] ??
        'https://www.verywellfamily.com/thmb/vy3Au-X1TWDhdFNFcIJn_FfshMk=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/best-places-to-buy-kids-clothes-5190552-v1-d45adce7b25f414e89d16a85dc7e077f.jpg';
  }
}

class CategoryCard extends StatelessWidget {
  final String category;
  final int count;
  final String imageUrl;

  const CategoryCard({
    Key? key,
    required this.category,
    required this.count,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        // Overlay with gradient (optional)
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        // Text information
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$count Product',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
