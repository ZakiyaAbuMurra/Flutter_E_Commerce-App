import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommrac_app/models/product_item_model.dart';
import 'package:ecommrac_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductItemModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0, // Added to make AppBar transparent
        title: Text(widget.product.name),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (favProducts.contains(widget.product)) {
                  favProducts.remove(widget.product);
                } else {
                  favProducts.add(widget.product);
                }
              });
            },
            icon: Icon(
              favProducts.contains(widget.product)
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.6,
              decoration: BoxDecoration(
                color: AppColors.grey2,
              ),
              child: CachedNetworkImage(
                imageUrl: widget.product.imgUrl,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.48),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: AppColors.orange,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  widget.product.averageRate.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Add any other widgets here
                      ],
                    ),
                    // Add more widgets for product details here
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
