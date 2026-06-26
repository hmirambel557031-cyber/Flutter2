import 'package:flutter/material.dart';
import '../data/product_data.dart';
import '../models/product_model.dart';
import '../widgets/category_button.dart';
import '../widgets/product_grid.dart';
import 'checkout_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  static const List<String> categories = [
    "All",
    "Smartphones",
    "Laptops",
    "Tablets",
  ];

  int selectedIndex = 0;
  int currentNavIndex = 0;
  final Set<Product> favorites = {};
  final List<Product> cartItems = [];

  List<Product> get filteredProducts {
    if (selectedIndex == 0) return products;
    return products
        .where((p) => p.category == categories[selectedIndex])
        .toList();
  }

  void toggleFavorite(Product product) {
    setState(() {
      if (favorites.contains(product)) {
        favorites.remove(product);
      } else {
        favorites.add(product);
      }
    });
  }

  void addToCart(Product product) {
    setState(() {
      cartItems.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${product.name} added to cart!"),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.blue,
      ),
    );
  }

  // ✅ Clears cart when order is cancelled or placed
  void clearCart() {
    setState(() {
      cartItems.clear();
    });
  }

  void goToCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(
          cartItems: cartItems,
          onOrderCancelled: clearCart, // ✅ Pass clearCart callback
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mirambel E-Commerce App"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: goToCheckout,
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "${cartItems.length}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: currentNavIndex == 0 ? _buildHome() : _buildFavorites(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentNavIndex,
        onTap: (index) {
          setState(() {
            currentNavIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),
    );
  }

  Widget _buildHome() {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              for (int i = 0; i < categories.length; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CategoryButton(
                    title: categories[i],
                    isSelected: selectedIndex == i,
                    onTap: () {
                      setState(() {
                        selectedIndex = i;
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: ProductGrid(
            products: filteredProducts,
            favorites: favorites,
            onFavorite: toggleFavorite,
            onAddToCart: addToCart,
          ),
        ),
      ],
    );
  }

  Widget _buildFavorites() {
    if (favorites.isEmpty) {
      return const Center(child: Text("No favorites yet."));
    }
    return ProductGrid(
      products: favorites.toList(),
      favorites: favorites,
      onFavorite: toggleFavorite,
      onAddToCart: addToCart,
    );
  }
}
