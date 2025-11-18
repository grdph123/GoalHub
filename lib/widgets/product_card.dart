import 'package:flutter/material.dart';
import '../screens/productlist_form.dart';
import '../screens/product_list.dart'; // Import untuk All Products
import '../screens/my_products.dart';

class ProductItem {
  final String name;
  final IconData icon;
  final Color color;

  ProductItem(this.name, this.icon, this.color);
}

class ProductCard extends StatelessWidget {
  final ProductItem item;

  const ProductCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("You pressed ${item.name}!"))
            );

          if (item.name == "Create Product") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductFormPage()),
            );
          // Di dalam onTap, tambahkan:
          } else if (item.name == "My Products") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyProductsPage()),
            );
          } else if (item.name == "All Products") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductListPage()),
            );
          } else if (item.name == "My Products") {
            // TODO: Tambahkan navigasi ke My Products page
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("My Products feature coming soon!")),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(6), // Padding lebih kecil untuk horizontal
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 20.0, // Icon lebih kecil
                ),
                const SizedBox(height: 4),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10, // Font lebih kecil
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}