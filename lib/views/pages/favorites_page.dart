import 'package:ecommrac_app/models/product_item_model.dart';
import 'package:ecommrac_app/services/firestore_services.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<ProductItemModel>> _futureFavorites;
  final FirestoreService _firestoreService =
      FirestoreService.instance; // Singleton instance
  List<ProductItemModel> favorites = []; // This holds  favorite items

  @override
  void initState() {
    super.initState();
    _futureFavorites = _fetchFavorites();
  }

  Future<List<ProductItemModel>> _fetchFavorites() async {
    final firestoreService = FirestoreService.instance;
    return firestoreService.getCollection<ProductItemModel>(
      path: 'favorites',
      builder: (data, documentId) => ProductItemModel.fromMap(data, documentId),
    );
  }

  void _removeFromFavorites(String productId, int index) async {
    try {
      await _firestoreService.removeFavorite(productId);
      setState(() {
        favorites.removeAt(index);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Favorite removed successfully.'),
        ),
      );
    } catch (e) {
      print(e); // For debugging purposes

      // Provide user feedback about the error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'There was an error removing the favorite. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: FutureBuilder<List<ProductItemModel>>(
        future: _futureFavorites,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No favorites added yet.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    leading: Image.network(
                      product.imgUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: () => _removeFromFavorites(product.id, index),
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
}
