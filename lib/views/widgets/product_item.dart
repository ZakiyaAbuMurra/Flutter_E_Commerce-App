import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommrac_app/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommrac_app/models/product_item_model.dart';
import 'package:ecommrac_app/utils/app_colors.dart';

class ProductItem extends StatefulWidget {
  final ProductItemModel productItem;
  const ProductItem({super.key, required this.productItem});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool _isFavorite = false;
  final FirestoreService _firestoreService = FirestoreService.instance;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
  final String userId = 'your_user_id'; // This should be dynamically set based on the logged-in user
  final String productId = widget.productItem.id;
  
  final DocumentSnapshot favoriteSnapshot = await _firestoreService.firestore
      .collection('users')
      .doc(userId)
      .collection('favorites')
      .doc(productId)
      .get();

  setState(() {
    _isFavorite = favoriteSnapshot.exists;
  });
}

  void _toggleFavorite() async {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    if (_isFavorite) {
      // Assume productItem.toMap() is a method on your model that converts it to a Map
      await _firestoreService.addFavorite(widget.productItem.id, widget.productItem.toMap());
    } else {
      await _firestoreService.removeFavorite(widget.productItem.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              height: 130,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: AppColors.grey2,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: widget.productItem.imgUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8.0,
              right: 8.0,
              child: InkWell(
                onTap: _toggleFavorite,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Flexible(
          child: Text(
            widget.productItem.name,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.grey,
                ),
          ),
        ),
        Text(
          '\$${widget.productItem.price.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
