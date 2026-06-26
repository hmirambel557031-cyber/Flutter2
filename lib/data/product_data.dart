import "../models/product_model.dart";

const List<Product> products = [
  Product(
    name: "Apple iPhone 17 Pro Max",
    price: 1199.00,
    description:
        "The Apple iPhone 17 Pro Max is the latest flagship smartphone from Apple, featuring a stunning design, powerful performance, and advanced camera capabilities.",
    stock: 50,
    image: "assets/IPhone 17.png",
    category: "Smartphones",
  ),
  Product(
    name: "Apple MacBook Pro 14-inch M5",
    price: 1599.00, //
    description:
        "The Apple MacBook Pro 14-inch M5 is a high-performance laptop designed for professionals and power users.",
    stock: 30,
    image: "assets/macbook-pro-14-inch-m5.png",
    category: "Laptops",
  ),
  Product(
    name: "Apple iPad Pro",
    price: 799.00, //
    description:
        "The Apple iPad Pro is a powerful and versatile tablet designed for both work and play.",
    stock: 20,
    image: "assets/Ipad.png",
    category: "Tablets",
  ),
];
