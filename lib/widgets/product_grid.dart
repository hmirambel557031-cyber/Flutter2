import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final Set<Product> favorites;
  final ValueChanged<Product> onFavorite;
  final ValueChanged<Product> onAddToCart; // ✅ Added

  const ProductGrid({
    super.key,
    required this.products,
    required this.favorites,
    required this.onFavorite,
    required this.onAddToCart, // ✅ Added
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          isFavorite: favorites.contains(product),
          onFavorite: () => onFavorite(product),
          onAddToCart: () => onAddToCart(product), // ✅ Added
        );
      },
    );
  }
}
